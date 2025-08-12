class_name UILayer
extends CanvasLayer

func _ready() -> void:
	var is_touchscreen = DisplayServer.is_touchscreen_available()
	
	$Controls/Left.visible = is_touchscreen
	$Controls/Right.visible = is_touchscreen
	$Controls/Jump.visible = is_touchscreen
	
	connect_virtual_button($Controls/Left, "move_left")
	connect_virtual_button($Controls/Right, "move_right")
	connect_virtual_button($Controls/Jump, "jump")

func show_win_screen(flag: bool) -> void:
	$WinScreen.visible = flag
	$Controls.visible = !flag
		

func connect_virtual_button(btn: Button, action: StringName):
	btn.button_down.connect(create_button_event_handler(action, true))
	btn.button_up.connect(create_button_event_handler(action, false))

func fire_input_event(action: StringName, pressed: bool):
	var event = InputEventAction.new()
	event.action = action
	event.pressed = pressed
	Input.parse_input_event(event)

func create_button_event_handler(action: StringName, pressed: bool):
	var handler = func():
		fire_input_event(action, pressed)
		
	return handler
