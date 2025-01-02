extends Node2D

@export var _scroll_speed : float = -100
@export var _width: float = 896

@onready var _big_cloud1 : Sprite2D = $BigClouds
@onready var _big_cloud2 : Sprite2D = $BigClouds2
@onready var _small_cloud1 : Sprite2D = $SmallCloud1
@onready var _small_cloud2 : Sprite2D = $SmallCloud2
@onready var _small_cloud3 : Sprite2D = $SmallCloud3

func _process(delta: float) -> void:
	_scroll(_big_cloud1, _scroll_speed * delta)
	_scroll(_big_cloud2, _scroll_speed * delta)
	_scroll(_small_cloud1, _scroll_speed * delta / 7)
	_scroll(_small_cloud2, _scroll_speed * delta / 5)
	_scroll(_small_cloud3, _scroll_speed * delta / 3)
	
	
func _scroll(cloud: Node2D, distance: float) -> void:
	cloud.position.x += distance
	if cloud.position.x < _width * -1:
		cloud.position.x += _width * 2
