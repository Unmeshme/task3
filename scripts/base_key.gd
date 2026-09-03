class_name BaseKey


extends Control


#member variables
#false is default alpha numeric value

export var key_name : String = ""

export var top_left_corner_radius: 		int = 0
export var top_right_corner_radius: 		int = 0
export var bottom_left_corner_radius: 	int = 0
export var bottom_right_corner_radius: 	int = 0


#also need dimension
export var key_dimension: Vector2 = Vector2.ZERO

onready var panel: Panel = $Panel
onready var label: Label = $Panel/Label


var is_shifted: bool = false



func _ready() -> void:
	
	rect_min_size = key_dimension
	rect_size = key_dimension
	panel.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	change_panel_vals()
	label.text = key_name



func change_panel_vals() -> void:
	
	var m_current_style: StyleBoxFlat = panel.get_stylebox("panel")
	var m_style: StyleBoxFlat = m_current_style.duplicate()
	
	m_style.corner_radius_top_right 		= top_right_corner_radius
	m_style.corner_radius_top_left 		= top_left_corner_radius
	m_style.corner_radius_bottom_right 	= bottom_right_corner_radius
	m_style.corner_radius_bottom_left 	= bottom_left_corner_radius

	panel.add_stylebox_override("panel", m_style)
	


func _on_Panel_gui_input(event: InputEvent) ->void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print(key_name)


#first return shifted as true whenever we get a key that can make it high
#that is whenever shift is constantly being pressed or when
#capslock has been pressed
#check for scancode and unicode if they are same return it else return the unicode
#rather its better to just do: everything as scan code except for non alphanumeric
#keys well echo is firing too quickly
#quick note to self the _input is being ran by every instance of base class which
#results in the current excessive printing
#study the fix and then fix it next time and then all that left is building the
#keyboard
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.is_echo():
		var character := char(event.unicode)

		if character.length() == 1 and character.is_valid_identifier():
			print(character)
		else:
			print(OS.get_scancode_string(event.physical_scancode))

