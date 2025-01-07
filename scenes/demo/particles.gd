@tool

extends Node2D

@export var Particles: int = 10000:
	set(amount):
		Particles = amount
		if not particleSystem == null: 
			particleSystem.editor_amount = amount

@onready var particleSystem : EditorParticles = $EditorParticles as EditorParticles

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("running tool ready")
	if not particleSystem == null: 
		particleSystem.editor_amount = Particles
