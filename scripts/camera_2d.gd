extends Camera2D

@export var _subject: Character
@export var _offset: Vector2 = Vector2(64, -10)
@export var _duration: float = 0.5
@export var _trans_type: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
@export var _easy_type: Tween.EaseType = Tween.EaseType.EASE_OUT

@onready var _lookahead_distance: float = _offset.x
var _lookahead_tween: Tween

@onready var _floor_height: float = _subject.position.y
var _floor_height_tween: Tween


func _ready() -> void:
	_subject.changed_direction.connect(_on_character_direction_changed)
	_subject.landed.connect(_on_character_landed)


func _process(delta: float) -> void:
	position.x = _subject.position.x + _lookahead_distance
	position.y = _floor_height + _offset.y


func _on_character_direction_changed(direction: Character.Direction) -> void:
	if _lookahead_tween && _lookahead_tween.is_running():
		_lookahead_tween.kill()

	_lookahead_tween = create_tween().set_ease(_easy_type).set_trans(_trans_type)
	_lookahead_tween.tween_property(self, "_lookahead_distance", _offset.x * (-1 if direction == Character.Direction.LEFT else 1), _duration)


func _on_character_landed(floor_height: float) -> void:
	if _floor_height_tween && _floor_height_tween.is_running():
		_floor_height_tween.kill()

	_floor_height_tween = create_tween().set_ease(_easy_type).set_trans(_trans_type)
	_floor_height_tween.tween_property(self, "_floor_height", floor_height, _duration)
