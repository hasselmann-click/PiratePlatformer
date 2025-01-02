extends Area2D

@export var _splash: PackedScene

@onready var _sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _spawn_splash(x: float) -> void:
	var splash = _splash.instantiate() as AnimatedSprite2D
	assert(splash is AnimatedSprite2D, "splash needs to be an AnimatedSprite2D")
	add_child(splash)
	splash.global_position.x = x
	_sfx.play()


func _on_body_entered(body: Node2D) -> void:
	_spawn_splash(body.position.x)
	if body is Character:
		body.enter_water(position.y)


func _on_body_exited(body: Node2D) -> void:
	if body is Character:
		if body.position.y - Globals.pixelsPerTile / 2 <= position.y:
			_spawn_splash(body.position.x)
			body.exit_water()
		else:
			body.dive()
