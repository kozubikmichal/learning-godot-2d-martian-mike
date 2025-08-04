class_name HUD
extends Control

@onready var time_label = $TimeLabel

func set_time_label(value) -> void:
	time_label.text = "TIME: " + str(value)
