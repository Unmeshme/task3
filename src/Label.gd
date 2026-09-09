extends Label



func set_font_size(p_new_size: int) -> void:
	var m_font: DynamicFont = get_font("font")
	
	if m_font:
		var m_new_font: DynamicFont = m_font.duplicate()
		m_new_font.size = p_new_size
		print(m_new_font.size)
		#but this override isn't occuring
		add_font_override("font", m_new_font)
		update()
	
