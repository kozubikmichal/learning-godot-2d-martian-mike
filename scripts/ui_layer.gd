class_name UILayer
extends CanvasLayer

func _ready() -> void:
	$Controls.visible = DisplayServer.is_touchscreen_available()
	
	connect_virtual_button($Controls/MoveLeft, "move_left")
	connect_virtual_button($Controls/MoveRight, "move_right")
	connect_virtual_button($Controls/Jump, "jump")

func show_win_screen(flag: bool) -> void:
	$WinScreen.visible = flag
	$Controls.visible = !flag && DisplayServer.is_touchscreen_available()
		

func connect_virtual_button(btn: TouchScreenButton, action: StringName):
	btn.pressed.connect(func():
		fire_input_event(action, true)
	)
	btn.released.connect(func():
		fire_input_event(action, false)
	)

func fire_input_event(action: StringName, pressed: bool):
	var event = InputEventAction.new()
	event.action = action
	event.pressed = pressed
	Input.parse_input_event(event)
