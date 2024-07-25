extends Button

@export var action: String = "ui_up"

func _ready():
	set_process_unhandled_key_input(false)
	display_key()
	
func display_key():
	text = "%s" % Input.get_action_list(action)[0].as_text()
	

func _on_toggled(button_pressed):
	set_process_unhandled_key_input(button_pressed)
	if button_pressed:
		text = ". . ."
	else:
		display_key()

func _unhandled_key_input(event):
	remap_key(event)
	pressed = false

func remap_key(event):
	In
