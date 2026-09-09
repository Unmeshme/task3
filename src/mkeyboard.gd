extends Control


func _input(p_event: InputEvent) -> void:
	if p_event is InputEventKey and p_event.pressed and !p_event.is_echo():
		if p_event.scancode == KEY_SPACE:
			print("Space")
		
		if p_event.unicode != 0:
			print(char(p_event.unicode))
		else:
			print(OS.get_scancode_string(p_event.physical_scancode))
