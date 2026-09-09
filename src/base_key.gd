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



func _ready() -> void:
	
	#rect_min_size = key_dimension
	#rect_size = key_dimension
	panel.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	#change_panel_vals()
	#label_text.text = key_name



func change_panel_vals() -> void:
	panel.add_stylebox_override("panel", Globals.Key_info_t.esc.get("border_style", ""))


func _on_Panel_gui_input(p_event: InputEvent) ->void:
	if p_event is InputEventMouseButton:
		if p_event.button_index == BUTTON_LEFT and p_event.pressed:
			if key_name == "":
				return		
			else:
				print(key_name)


func setup(p_data: Dictionary) -> void:
	key_name = p_data.get("key_name", "")
	label = p_data.get("label", "")
	
	if label_text:
		label_text.text = label
	
	size_flags_horizontal = SIZE_FILL
	size_flags_vertical = SIZE_SHRINK_CENTER
	
	var m_width = p_data.get("width", 67)
	var m_height = p_data.get("height", 67)

	if key_name == "up_arrow" || key_name == "down_arrow":
		rect_min_size = Vector2(67,28)
		rect_size = Vector2(67, 28)
		panel.rect_min_size = Vector2(67,31)
	else:
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


func _style_bottom_center() -> void:
	label_text.align = Label.ALIGN_CENTER
	label_text.valign = Label.VALIGN_BOTTOM
	
	label_text.margin_bottom = -5
