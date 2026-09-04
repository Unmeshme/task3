extends Panel

const SCENES = {
	1: preload("res://scripts/base_key.tscn"),
	2: preload("res://scripts/function_key.tscn"),
	3: preload("res://scripts/shiftable_key.tscn"),
}

const LAYOUT_PATH = "res://assets/key_info.json"

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
			if SCENES.has(m_type_id):
				var m_key_instance = SCENES[m_type_id].instance()
				rows[m_row_idx].add_child(m_key_instance)
				
				if m_key_instance.has_method("setup"):
					m_key_instance.setup(m_key_data)



func _sort_by_order(a: Dictionary, b: Dictionary) -> bool:
	return a.get("order", 0) < b.get("order", 0)
