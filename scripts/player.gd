class_name Player
extends CharacterBody2D

@export var speed: float = 125.0
@export var jump_velocity: float = 200.0
@export var gravity: float = 400

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	handle_move(delta)
	handle_animation()
	move_and_slide()
	
func handle_move(delta: float) -> void:
	if !is_on_floor():
		velocity.y += min(gravity * delta, 500)
	else: 
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_velocity
		
	var direction = Input.get_axis("move_left", "move_right")
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

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
