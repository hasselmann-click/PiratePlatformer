class_name EditorParticles extends GPUParticles2D

@export var editor_amount: int = 9:
	set(_amount):
		editor_amount = _amount
		self.amount = _amount
		print("Running with %s particles" % self.amount)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Running with %s particles" % self.amount)
