extends BaseKey

#it can be icon + label class if I am feeling like it
export var texture_icon: Texture


onready var icon: TextureRect = $Panel/icon

var key_icons: Array = [
	"res://assets/icons/apple-keyboard-option.png",
	"res://assets/icons/brightness-2.png",
	"res://assets/icons/brightness.png",
	"res://assets/icons/command.png",
	"res://assets/icons/rewind.png",
	"res://assets/icons/volume-down.png",
	"res://assets/icons/volume-up.png",
]
#write code to make the icons work properly
#for certain icons

func _ready() -> void:
	._ready()
	#this is only if we use the gui but I am going to write it directly with code
	icon.texture = texture_icon

#lol rn fucntion key is just base key huh
func setup(p_data: Dictionary) -> void:
	.setup(p_data)
	#now have to make sure the images are placed correctly with correct sizing
	if key_name == "command_left" or key_name == "command_right"\
	or key_name == "option_left" or key_name == "option_right" or key_name == "control":
		_style_bottom_center()
	#everyone of these checks can be made faster by using their correspoinding id
	if key_name == "f1" or key_name == "f2" or key_name == "f3" or key_name == "f4"\
		or key_name == "f5" or key_name == "f6" or key_name == "f7" or key_name == "f8"\
		or key_name == "f9" or key_name == "f10" or key_name == "f11" or key_name == "f12":
		_style_bottom_center()
		label_text.set_font_size(10)
		initiate_icons("res://assets/icons/eject.png")
	
	if key_name == "fn":
		_style_top_right()
		initiate_icons("res://assets/icons/command.png")
		_style_icon_top_center()


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
