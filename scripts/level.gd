extends Node2D

@export var next_level: PackedScene = null
@export var level_time = 5
@export var is_final_level: bool = false

@onready var player = $Player
@onready var start: Start = $Start
@onready var exit = $Exit
@onready var deathzone = $Deathzone
@onready var hud = $UILayer/HUD

var timer_node: Timer = null
var time_left = 0
var win = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_player()
	setup_traps()
	setup_exits()
	setup_timer()

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
		AudioPlayer.play_sfx("hurt")
		reset_player()


func _on_trap_touched_player() -> void:
	AudioPlayer.play_sfx("hurt")
	reset_player()
	
func _on_exit_body_entered(body) -> void:
	if body is not Player:
		return
	
	if is_final_level:
		handle_player_won_level()
		$UILayer.show_win_screen(true)
	elif next_level != null:
		handle_player_won_level()
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(next_level)

func handle_player_won_level() -> void:
	exit.animate()
	player.active = false
	win = true

func reset_player() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_position()

func setup_traps() -> void:
	var traps = get_tree().get_nodes_in_group("traps")
	
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)

func setup_exits() -> void:
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)

func setup_timer() -> void:
	reset_timer()
	
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	
	timer_node.start()
	
func reset_timer() -> void:
	time_left = level_time
	hud.set_time_label(time_left)

func _on_level_timer_timeout() -> void:
	time_left -= 1
	if (!win): 
		if (time_left < 0):
			reset_player()
			reset_timer()
		else: 
			hud.set_time_label(time_left)
