class_name Exit
extends Area2D

@onready var sprite = $AnimatedSprite2D

func animate() -> void:
	sprite.play("default")
