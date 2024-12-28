extends Node


func _ready() -> void:
	var output1 := []
	var err := -1
	err = OS.execute("where", ["gdformat"], output1)
	print(output1, err)

	# Use cmd.exe to run gdformat
	#var command = "C:/Users/bj13_/source/godot/WinPy/python/Scripts/gdformat.exe"
	var command = "gdformat"
	var arguments = ["--version"]

	var output := []
	err = OS.execute(command, arguments, output, true)  # Capture stderr
	print(output, err)
