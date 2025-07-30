class_name Player
extends CharacterBody2D

@export var speed: float = 125.0
@export var jump_velocity: float = 200.0
@export var gravity: float = 400

@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta: float) -> void:
	handle_move(delta)
	handle_animation()
	move_and_slide()
	
func handle_move(delta: float) -> void:
	if !is_on_floor():
		velocity.y += min(gravity * delta, 500)
	elif active: 
		if Input.is_action_just_pressed("jump"):
			jump(jump_velocity)
		
	var direction = Input.get_axis("move_left", "move_right") if active else 0.0
	velocity.x = direction * speed
		
func handle_animation() -> void:
	if velocity.x:
		animated_sprite.flip_h = velocity.x < 0
		
	if is_on_floor():
		if (velocity.x): 
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("fall" if velocity.y > 0 else "jump")

func jump(force: float) -> void:
	velocity.y = -force
