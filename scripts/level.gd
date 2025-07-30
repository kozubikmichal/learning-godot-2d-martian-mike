extends Node2D

@export var next_level: PackedScene = null

@onready var player = $Player
@onready var start: Start = $Start
@onready var exit = $Exit
@onready var deathzone = $Deathzone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_player()
	var traps = get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)
		
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_system_inputs()

func check_system_inputs() -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body: Node2D) -> void:
	if body is Player:
		reset_player()


func _on_trap_touched_player() -> void:
	reset_player()
	
func _on_exit_body_entered(body) -> void:
	if body is not Player and next_level != null:
		return
	
	exit.animate()
	player.active = false
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_packed(next_level)

func reset_player() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_position()
