class_name BulletServer extends Node2D

@export var BulletCount: int = 2000
@export var SpeedMin: float = 100
@export var SpeedMax: float = 150

@onready var player: Player = $Player

const BULLET_IMAGE = preload("res://assets-synced/demo/bullet.png")

var bullets: Dictionary = {}  # [RID, Bullet]
var shape  # resource reference, otherwise it will be GC'd if no bullet is on screen


class Bullet:
	var active := true
	var position := Vector2()
	var speed := 1.0
	var body := RID()


func _ready() -> void:
	player.body_shape_entered.connect(_on_collision)

	# TODO: how to instantiate custom shapes?
	shape = PhysicsServer2D.circle_shape_create()
	# set data interprets the parameter depending on the shape's type
	PhysicsServer2D.shape_set_data(shape, 8)

	# fill bullets array
	for _i in BulletCount:
		var bullet = Bullet.new()
		bullet.speed = randf_range(SpeedMin, SpeedMax)

		bullet.body = PhysicsServer2D.body_create()
		# defaults, but for demonstration purposes:
		PhysicsServer2D.body_set_mode(bullet.body, PhysicsServer2D.BodyMode.BODY_MODE_RIGID)
		#PhysicsServer2D.body_set_collision_mask(bullet.body, 1)

		PhysicsServer2D.body_set_space(bullet.body, get_world_2d().get_space())
		PhysicsServer2D.body_add_shape(bullet.body, shape)
		# don't collide with other bullets
		PhysicsServer2D.body_set_collision_mask(bullet.body, 0)

		# Place bullets randomly on the viewport and move bullets outside the
		# play area so that they fade in nicely.
		bullet.position = Vector2(
			# TODO: does this mean they're fading in from the right?
			randf_range(0, get_viewport_rect().size.x) + get_viewport_rect().size.x,
			randf_range(0, get_viewport_rect().size.y)
		)

		var transform2d = Transform2D()
		transform2d.origin = bullet.position
		PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_SLEEPING, false)

		bullets[bullet.body] = bullet


func _on_collision(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	var bullet = bullets.get(body_rid) as Bullet
	if bullet == null:
		pass
	bullet.active = false
	PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_SLEEPING, true)


func _process(delta: float) -> void:
	# order canvas items to update every frame
	# TODO why is this necessary? Queues it at the end..?
	queue_redraw()


func _physics_process(delta: float) -> void:
	var transform2d = Transform2D()
	# for resetting bullet if it left the screen
	# TODO why 16, when bullet.png is 32x32?
	var offset = get_viewport_rect().size.x + 16
	for bullet in bullets.values():  # in "size()" gets size-1..
		bullet.position.x -= bullet.speed * delta

		# reset bullet to the right if it left the screen on the left
		if bullet.position.x < -16:
			PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_SLEEPING, false)
			bullet.active = true
			bullet.position.x = offset

		transform2d.origin = bullet.position
		PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_TRANSFORM, transform2d)


# Instead of drawing each bullet individually in a script attached to each bullet,
# we are drawing *all* the bullets at once here.
func _draw() -> void:
	var offset = -BULLET_IMAGE.get_size() * 0.5
	for bullet in bullets.values() as Array[Bullet]:  # in "size()" gets size-1..
		if not bullet.active:
			continue
		draw_texture(BULLET_IMAGE, bullet.position + offset)


# clean up (free all rids)
func _exit_tree() -> void:
	for bullet in bullets:
		PhysicsServer2D.free_rid(bullet.body)

	PhysicsServer2D.free_rid(shape)
	bullets.clear()
