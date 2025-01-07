extends Node2D

@onready var _camera: Camera2D = $Camera2D
@onready var _player: CharacterBody2D = $Roger
@onready var _level: Level = $Level

func _ready() -> void:
	var min_boundary = _level.get_min()
	var max_boundary = _level.get_max()
	
