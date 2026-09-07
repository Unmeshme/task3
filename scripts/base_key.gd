class_name BaseKey


extends Control


#member variables
#false is default alpha numeric value

export var key_name : String = ""
export var label: String = ""
export var top_left_corner_radius: 		int = 0
export var top_right_corner_radius: 		int = 0
export var bottom_left_corner_radius: 	int = 0
export var bottom_right_corner_radius: 	int = 0


#also need dimension
export var key_dimension: Vector2 = Vector2.ZERO

onready var panel: Panel = $Panel
onready var label_text: Label = $Panel/Label


var is_caps_on: bool = false



func _ready() -> void:
	
	#rect_min_size = key_dimension
	#rect_size = key_dimension
	panel.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	#change_panel_vals()
	#label_text.text = key_name



func change_panel_vals() -> void:
	
	var m_current_style: StyleBoxFlat = panel.get_stylebox("panel")
	var m_style: StyleBoxFlat = m_current_style.duplicate()
	
	m_style.corner_radius_top_right 	= top_right_corner_radius
	m_style.corner_radius_top_left 		= top_left_corner_radius
	m_style.corner_radius_bottom_right 	= bottom_right_corner_radius
	m_style.corner_radius_bottom_left 	= bottom_left_corner_radius

	panel.add_stylebox_override("panel", m_style)
	


func _on_Panel_gui_input(p_event: InputEvent) ->void:
	if p_event is InputEventMouseButton:
		if p_event.button_index == BUTTON_LEFT and p_event.pressed:
			if key_name == "":
				return		
			else:
				if key_name == "caps_lock":
					is_caps_on = !is_caps_on
				print(key_name)


func setup(p_data: Dictionary) -> void:
	key_name = p_data.get("key_name", "")
	label = p_data.get("label", "")
	
	# Assign text to UI node
	if label_text:
		label_text.text = label
		
	# Set Control node dimensions
	var m_width = p_data.get("width", 64)
	var m_height = p_data.get("height", 64)
	rect_min_size = Vector2(m_width, m_height)
	rect_size = Vector2(m_width, m_height)
	
	if label_text.text == "delete" || label_text.text == "return" || key_name == "right_shift":
		_style_bottom_right()
		
	if label_text.text == "caps lock" || label_text.text == "tab" ||\
	   key_name == "left_shift" || label_text.text == "esc":
		_style_bottom_left()
	
	
	_apply_corners(p_data.get("corners", {}))
	



func _apply_corners(p_corners: Dictionary) -> void:
	if not panel:
		return
		
	# Duplicate StyleBoxFlat from Panel child node
	var m_current_style: StyleBoxFlat = panel.get_stylebox("panel")
	var m_style: StyleBoxFlat = m_current_style.duplicate()
	
	m_style.corner_radius_top_left = p_corners.get("top_left", 10)
	m_style.corner_radius_top_right = p_corners.get("top_right", 10)
	m_style.corner_radius_bottom_left = p_corners.get("bottom_left", 10)
	m_style.corner_radius_bottom_right = p_corners.get("bottom_right", 10)

	panel.add_stylebox_override("panel", m_style)


func _style_bottom_right() -> void:
	label_text.align = Label.ALIGN_RIGHT
	label_text.valign = Label.VALIGN_BOTTOM
	
	label_text.margin_right = -5
	label_text.margin_bottom = -5


func _style_bottom_left() -> void:
	label_text.align = Label.ALIGN_LEFT
	label_text.valign = Label.VALIGN_BOTTOM
	
	label_text.margin_left = 5
	label_text.margin_bottom = -5
