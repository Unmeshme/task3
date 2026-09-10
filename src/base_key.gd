class_name BaseKey


extends Control

var keys_id: int = 0
var key_data: Dictionary = {}

onready var panel: Panel = $Panel
onready var label_text: Label = $Panel/Label
onready var animation_tween: Tween = $Tween

#now it only updates in gui events lol
func _on_Panel_gui_input(p_event: InputEvent) ->void:
	if p_event is InputEventMouseButton:
		if p_event.button_index == BUTTON_LEFT and p_event.pressed:
			var m_is_shifted: bool = Input.is_key_pressed(KEY_SHIFT)

			var m_key_event: InputEvent = InputEventKey.new()
			m_key_event.physical_scancode = keys_id
			m_key_event.pressed = true

			var m_char: String = get_character(m_is_shifted)
			if m_char != "" and m_char.length() < 2:
				m_key_event.unicode = m_char.ord_at(0)
				
			var m_release_event := InputEventKey.new()
			m_release_event.physical_scancode = keys_id
			m_release_event.pressed = false
			
			Input.parse_input_event(m_key_event)
			Input.parse_input_event(m_release_event)


func get_character(p_shift: bool) -> String:
	var m_character : String = key_data["key_name"]
	if keys_id >= KEY_A and keys_id <= KEY_Z:
		#is a unicode with single character
		if p_shift != Globals.is_caps:
			return m_character.to_upper()
		else:
			return m_character.to_lower()
			
	if p_shift and key_data.has("shift_label"):
		return key_data.get("shift_label", "")
		
	return m_character
	

func setup(p_data: Dictionary) -> void:
	key_data = p_data
	var m_key_name: String = key_data.get("key_name", "")
	keys_id = key_data.get("key_id", 0)
		
	if label_text:
		if keys_id == KEY_SPACE:
			label_text.text = ""
		else:
			label_text.text = m_key_name
	
	rect_min_size = key_data.get("size", {})
	panel.rect_min_size = rect_min_size
	_apply_corners(key_data.get("border_style", {}))


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


func animate_key_presses() -> void:
	
	animation_tween.stop_all()
	var m_original_size : Vector2 = key_data["size"]
	var m_target_size: Vector2 = 0.9 * m_original_size
	animation_tween.interpolate_property(panel, "rect_min_size", m_original_size, m_target_size, 0.1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	animation_tween.interpolate_property(
		panel, 
		"rect_min_size", 
		m_target_size, 
		m_original_size, 
		0.1, 
		Tween.TRANS_QUAD, 
		Tween.EASE_OUT, 
		0.1
	)
	
	animation_tween.start()
	
