extends Panel

const SCENES = {
	1: preload("res://scripts/base_key.tscn"),
	2: preload("res://scripts/function_key.tscn"),
	3: preload("res://scripts/shiftable_key.tscn"),
}

const LAYOUT_PATH = "res://assets/test.json"

onready var rows = [
	$parent/row1,
	$parent/row2,
	$parent/row3,
	$parent/row4,
	$parent/row5,
	$parent/row6
]

func _ready() -> void:
	var layout_data = load_json(LAYOUT_PATH)
	if layout_data:
		build_keyboard(layout_data)

func load_json(p_path: String) -> Array:
	var m_file: File = File.new()
	if not m_file.file_exists(p_path):
		push_error("JSON file not found at: " + p_path)
		return []
		
	m_file.open(p_path, File.READ)
	var m_parse_result = JSON.parse(m_file.get_as_text())
	
	m_file.close()
	
	if m_parse_result.error == OK:
		return m_parse_result.result
	else:
		push_error("JSON Parse Error at line %d: %s" % [m_parse_result.error_line, m_parse_result.error_string])
		return []

func build_keyboard(p_layout_data: Array) -> void:
	# Step 1: Clean all existing row children first
	for m_row in rows:
		for m_child in m_row.get_children():
			m_child.queue_free()
		
	# Step 2: Sort by order (low to high)
	p_layout_data.sort_custom(self, "_sort_by_order")
		
	# Step 3: Draw directly into target row index!
	for m_key_data in p_layout_data:
		var m_row_idx: int = m_key_data.get("row", 1) - 1
		var m_type_id: int = m_key_data.get("type_id", 1)
		
		# If row exists, spawn and append
		if m_row_idx >= 0 and m_row_idx < rows.size():
			# FIRST check if it's the split block, independent of m_type_id!
			if m_key_data.get("is_split_block", false) or m_key_data.get("key_name") == "up_down_block":
				var m_v_box: VBoxContainer = VBoxContainer.new()
				#honestly do I need these anymore?
				m_v_box.rect_min_size = Vector2(67,67)
				m_v_box.rect_size = Vector2(67, 67)
				
				m_v_box.size_flags_vertical = 0
				m_v_box.add_constant_override("separation", 5)
				m_v_box.alignment = BoxContainer.ALIGN_CENTER
				
				rows[m_row_idx].add_child(m_v_box)
				
				var m_up_data: Dictionary = m_key_data.get("up_key", {})
				var m_down_data: Dictionary = m_key_data.get("down_key", {})
				
				# Up Arrow
				var m_up_type_id: int = m_up_data.get("type_id", 1)
				if SCENES.has(m_up_type_id):
					var m_up_instance = SCENES[m_up_type_id].instance()
					m_v_box.add_child(m_up_instance)
					if m_up_instance.has_method("setup"):
						m_up_instance.setup(m_up_data)
				
				# Down Arrow
				var m_down_type_id: int = m_down_data.get("type_id", 1)
				if SCENES.has(m_down_type_id):
					var m_down_instance = SCENES[m_down_type_id].instance()
					m_v_box.add_child(m_down_instance)
					if m_down_instance.has_method("setup"):
						m_down_instance.setup(m_down_data)

			# Regular Key Handling
			elif SCENES.has(m_type_id):
				var m_key_instance = SCENES[m_type_id].instance()
				rows[m_row_idx].add_child(m_key_instance)
				if m_key_instance.has_method("setup"):
					m_key_instance.setup(m_key_data)
					

func _sort_by_order(a: Dictionary, b: Dictionary) -> bool:
	return a.get("order", 0) < b.get("order", 0)
