extends Camera2D

@export var _subject: Character
@export var _offset: Vector2 = Vector2(64, 1)
@export var _duration: float = 0.5

@onready var _lookahead_distance: float = _offset.x
#@onready var _floor_height: float = _subject.position.y * _offset.y

var _lookahead_tween: Tween
#var _floor_height_tween: Tween


func _ready() -> void:
	_subject.changed_direction.connect(_on_character_direction_changed)
	_subject.landed.connect(_on_character_landed)


func _process(delta: float) -> void:
	position.x = _subject.position.x + _lookahead_distance


func _on_character_direction_changed(direction: Character.Direction) -> void:
	if _lookahead_tween && _lookahead_tween.is_running():
		_lookahead_tween.kill()

	_lookahead_tween = create_tween()
	_lookahead_tween.tween_property(self, "_lookahead_distance", _offset.x * (-1 if direction == Character.Direction.LEFT else 1), _duration)


func _on_character_landed(floor_height: float) -> void:
	position.y = floor_height * _offset.y
