extends BaseKey

#it can be icon + label class if I am feeling like it
export var texture_icon: Texture


onready var icon: TextureRect = $Panel/icon

func _ready() -> void:
	._ready()
	#this is only if we use the gui but I am going to write it directly with code
	icon.texture = texture_icon

#lol rn fucntion key is just base key huh
func setup(p_data: Dictionary) -> void:
	.setup(p_data)


func initiate_icons(p_path: String) -> void:
	var m_texture : Texture = load(p_path)
	icon.texture = m_texture
	icon.expand = true
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED


func _style_top_right() -> void:
	label_text.align = Label.ALIGN_RIGHT
	label_text.valign = Label.VALIGN_TOP
	
	label_text.margin_right = -10
	label_text.margin_top = 5


#understand about the styling of the icons
func _style_icon_top_center() -> void:
	icon.rect_position = Vector2((rect_size.x)/2.0 , 10)
