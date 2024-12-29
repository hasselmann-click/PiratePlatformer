extends AnimatedSprite2D


func _ready() -> void:
	self.animation_finished.connect(_on_animation_finished)
	self.play()


func _on_animation_finished() -> void:
	self.queue_free()
