class_name BaseKey


extends Control

var keys_id: int = 0

onready var panel: Panel = $Panel
onready var label_text: Label = $Panel/Label



func _ready() -> void:
	panel.set_anchors_and_margins_preset(Control.PRESET_WIDE)



func change_panel_vals() -> void:
	panel.add_stylebox_override("panel", Globals.Key_info_t.esc.get("border_style", ""))


func _on_Panel_gui_input(p_event: InputEvent) ->void:
	if p_event is InputEventMouseButton:
		if p_event.button_index == BUTTON_LEFT and p_event.pressed:
			var m_key_event: InputEvent = InputEventKey.new()
			m_key_event.physical_scancode = keys_id
			m_key_event.pressed = true
			Input.parse_input_event(m_key_event)


func setup(p_data: Dictionary) -> void:
	var m_key_name: String = p_data.get("key_name", "")
	keys_id = p_data.get("key_id", 0)
		
	if label_text:
		if keys_id == KEY_SPACE:
			label_text.text = ""
		else:
			label_text.text = m_key_name
	
	rect_min_size = p_data.get("size", {})
	panel.rect_min_size = rect_min_size
	_apply_corners(p_data.get("border_style", {}))



func _apply_corners(p_style: StyleBox) -> void:
	if not panel:
		return

	var m_current_style: StyleBoxFlat = panel.get_stylebox("panel")
	var m_style: StyleBoxFlat = m_current_style.duplicate()
	
	m_style.corner_radius_top_left = p_style.corner_radius_top_left
	m_style.corner_radius_top_right = p_style.corner_radius_top_right
	m_style.corner_radius_bottom_left = p_style.corner_radius_bottom_left
	m_style.corner_radius_bottom_right = p_style.corner_radius_bottom_right

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
