extends Control



onready var key_press: AudioStreamPlayer = $key_press
onready var base: Panel = $base



func _input(p_event: InputEvent) -> void:
	if p_event is InputEventKey and p_event.pressed and !p_event.is_echo():
		key_press.stop()
		key_press.play()
		
		if p_event.physical_scancode == KEY_CAPSLOCK:
			Globals.is_caps = !Globals.is_caps
			print("CapsLock toggled: ", Globals.is_caps)
		elif p_event.physical_scancode == KEY_SPACE:
			print("Space")
		elif p_event.unicode != 0:
			print(char(p_event.unicode))
		else:
			# Fall back to physical_scancode if scancode is 0
			var code: int = p_event.scancode if p_event.scancode != 0 else p_event.physical_scancode
			print(OS.get_scancode_string(code))
