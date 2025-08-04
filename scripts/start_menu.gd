extends Control

@export var first_level: PackedScene = null

func _ready() -> void:
	$StartButton.pressed.connect(_on_press_start)
	$QuitButton.pressed.connect(_on_press_exit)

func _on_press_start() -> void:
	get_tree().change_scene_to_packed(first_level)

func _on_press_exit() -> void:
	get_tree().quit()
