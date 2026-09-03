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
export var key_width: int = 10
export var key_height: int = 10

onready var panel: Panel = $Panel
onready var label: Label = $Panel/Label


func _ready() -> void:
	
	panel.rect_size = Vector2(key_width, key_height)
	
	var m_style: StyleBoxFlat = StyleBoxFlat.new()
	
	m_style.corner_radius_top_right 		= top_right_corner_radius
	m_style.corner_radius_top_left 		= top_left_corner_radius
	m_style.corner_radius_bottom_right 	= bottom_right_corner_radius
	m_style.corner_radius_bottom_left 	= bottom_left_corner_radius
	
	panel.add_stylebox_override("panel", m_style)

	label.text = key_name


func _on_Panel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print(key_name)
