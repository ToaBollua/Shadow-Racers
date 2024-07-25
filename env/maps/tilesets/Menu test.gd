extends Node2D




func _on_button_pressed():
	get_tree().change_scene_to_file("res://env/maps/Forestal Fortress.tscn")
	pass # Replace with function body.


func _on_button_3_pressed():
	get_tree().quit()
	pass # Replace with function body.
