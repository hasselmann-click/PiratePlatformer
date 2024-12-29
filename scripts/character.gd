extends CharacterBody2D
class_name Character

@export_category("Locomotion")
@export var speed: float = 8
@export var acceleration: float = 16
@export var deceleration: float = 32

@export_category("Jump")
@export var jump_height: float = 2.5
@export var air_control: float = 0.5
@export var jump_dust: PackedScene

@onready var _sprite: Sprite2D = $Sprite2D

var _jump_velocity: float
var _direction: float:
	set = run
var _gravity: Vector2


# TODO: ready will not be called if the values are updated in the editor
# This won't work with the "pixesPerTile" multiplication...
func _ready():
	# init gravity, since dynamic gravity (get_gravity) is not ready yet
	var defaultGravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	var defaultGravityVector = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
	_gravity = defaultGravity * defaultGravityVector

	speed *= Globals.pixelsPerTile
	acceleration *= Globals.pixelsPerTile
	deceleration *= Globals.pixelsPerTile
	jump_height *= Globals.pixelsPerTile
	_jump_velocity = sqrt(jump_height * _gravity.y * 2) * -1


func face_left():
	_sprite.flip_h = true


func face_right():
	_sprite.flip_h = false


func run(direction: float):
	_direction = direction


func jump():
	if is_on_floor():
		velocity.y = _jump_velocity
		_spawn_dust(jump_dust)


func stop_jump():
	if velocity.y < 0:
		velocity.y = 0


func _physics_process(delta: float) -> void:
	if sign(_direction) == 1:
		face_right()
	elif sign(_direction) == -1:
		face_left()

	# update gravity (which won't be necessary for this game)
	var dynamicGravity = get_gravity()
	if dynamicGravity.y > 0 and dynamicGravity.y != _gravity.y:
		_gravity = dynamicGravity

	if is_on_floor():
		_ground_physics(delta)
	else:
		_air_physics(delta)

	move_and_slide()


func _air_physics(delta: float):
	velocity += _gravity * delta
	if _direction:
		velocity.x = move_toward(velocity.x, _direction * speed, acceleration * air_control * delta)


func _ground_physics(delta: float):
	if _direction == 0:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	elif velocity.x == 0 or sign(_direction) == sign(velocity.x):
		velocity.x = move_toward(velocity.x, _direction * speed, acceleration * delta)
	else:  # player wants to move in the opposite direction
		velocity.x = move_toward(velocity.x, _direction * speed, deceleration * delta)


func _spawn_dust(dust: PackedScene) -> void:
	var _dust = dust.instantiate() as AnimatedSprite2D
	assert(_dust is AnimatedSprite2D, "Dust needs to be an AnimatedSprite2D")
	_dust.position = position
	_dust.flip_h = _sprite.flip_h
	get_parent().add_child(_dust)  # make sibling, not player child
