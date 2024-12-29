@tool
extends EditorScript

const animationName = "run"
const sprite_paths = [
	"res://assets-synced/Treasure Hunters/Treasure Hunters/The Crusty Crew/Sprites/Pink Star/02-Run/Run 01.png",
	"res://assets-synced/Treasure Hunters/Treasure Hunters/The Crusty Crew/Sprites/Pink Star/02-Run/Run 02.png",
	"res://assets-synced/Treasure Hunters/Treasure Hunters/The Crusty Crew/Sprites/Pink Star/02-Run/Run 03.png",
	"res://assets-synced/Treasure Hunters/Treasure Hunters/The Crusty Crew/Sprites/Pink Star/02-Run/Run 04.png",
	"res://assets-synced/Treasure Hunters/Treasure Hunters/The Crusty Crew/Sprites/Pink Star/02-Run/Run 05.png",
	"res://assets-synced/Treasure Hunters/Treasure Hunters/The Crusty Crew/Sprites/Pink Star/02-Run/Run 06.png"
]


func _run():
	# Get the selected AnimationPlayer node in the editor
	var root = get_scene()
	var animation_player = root.get_node("Sprite2D/AnimationPlayer")
	if not animation_player:
		printerr("AnimationPlayer not found")
		return

	# Replace textures in all animations
	var animation = animation_player.get_animation(animationName)

	replace_textures_in_animation(animation, sprite_paths)
	print("Textures replaced")


func replace_textures_in_animation(animation: Animation, sprite_paths: Array):
	# Loop through all tracks to find the texture property tracks and remove them
	for trackIdx in animation.get_track_count():
		print("TrackIdx", trackIdx)
		var track_type = animation.track_get_type(trackIdx)
		var track_path = animation.track_get_path(trackIdx)
		print("track ", track_type, track_path)
		print("Subnames", track_path.get_concatenated_subnames())
		if track_type == Animation.TYPE_VALUE and track_path.get_concatenated_subnames().contains("texture"):
			print("removing track")
			animation.remove_track(trackIdx)
			break

	var track_path = NodePath(".:texture")  # Adjust this path to your specific needs
	print(track_path)
	var trackIdx = animation.add_track(Animation.TYPE_VALUE)
	print(trackIdx)
	animation.track_set_path(trackIdx, track_path)
	animation.length = sprite_paths.size() * 0.1
	# Add new tracks with the new textures
	for spriteIdx in sprite_paths.size():
		print(spriteIdx)
		var kidx = animation.track_insert_key(trackIdx, spriteIdx * 0.1, load(sprite_paths[spriteIdx]))  # Adjust the time as needed
		print("Kidx ", kidx)
