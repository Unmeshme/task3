extends Panel

const SCENES = {
	1: preload("res://src/base_key.tscn"),
	3: preload("res://src/function_key.tscn"),
	2: preload("res://src/shiftable_key.tscn"),
	4: preload("res://src/utility_key.tscn"),
}

#const LAYOUT_PATH = "res://assets/test.json"

onready var rows = [
	$parent/row1,
	$parent/row2,
	$parent/row3,
	$parent/row4,
	$parent/row5,
	$parent/row6
]


const LAYOUT_QWERTY = [
	["esc", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "lock"],
	["tilde", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "plus", "delete"],
	["tab", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "bracket_left", "bracket_right", "forward_slash"],
	["caps_lock", "A", "S", "D", "F", "G", "H", "J", "K", "L", "semi-colon", "apostrophe", "return"],
	["l_shift", "Z", "X", "C", "V", "B", "N", "M", "comma", "full_stop", "backslash", "r_shift"],
	["fn", "control", "l_option", "l_command", "space", "r_command", "r_option", "l_arrow", "up_down_block", "r_arrow"]
]


func _ready() -> void:
	test_build_keyboard()


#might have to keep track of which row we should be building in
func test_build_keyboard() -> void:
	for m_rows in rows:
		for m_child in m_rows.get_children():
			m_child.queue_free()
		
	for m_row_idx in range(LAYOUT_QWERTY.size()):
		if m_row_idx >= rows.size():
			break
			
		var m_target_row = rows[m_row_idx]
		var m_keys_row = LAYOUT_QWERTY[m_row_idx]
			
		for m_key_name in m_keys_row:
			if m_key_name == "up_down_block":
				_spawn_arrow_block(m_target_row)
				continue
			if not Globals.Key_info_t.has(m_key_name):
				continue
			
			var m_data: Dictionary = Globals.Key_info_t[m_key_name]
			var m_type_id: int = m_data.get("id", 1)
			
			if SCENES.has(m_type_id):
				var m_instance = SCENES[m_type_id].instance()
				m_target_row.add_child(m_instance)
				
				if m_instance.has_method("setup"):
					m_instance.setup(m_data)


func _spawn_arrow_block(p_target_row: HBoxContainer) -> void:
	var m_v_box = VBoxContainer.new()
	m_v_box.rect_min_size = Vector2(67, 67)
	m_v_box.add_constant_override("separation", 5)
	
	p_target_row.add_child(m_v_box)
	
	for m_arrow_key in ["up_arrow", "down_arrow"]:
		if Globals.Key_info_t.has(m_arrow_key):
			var m_data: Dictionary = Globals.Key_info_t[m_arrow_key]
			var m_type_id: int = m_data.get("id", 1)
			if SCENES.has(m_type_id):
				var m_instance = SCENES[m_type_id].instance()
				m_v_box.add_child(m_instance)
				if m_instance.has_method("setup"):
					m_instance.setup(m_data)

