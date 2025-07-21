extends Node2D

@onready var player = $Player
@onready var start_position = $StartPosition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_system_inputs()

func check_system_inputs() -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		reset_player()


func _on_trap_touched_player() -> void:
	reset_player()

func reset_player() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = start_position.global_position
