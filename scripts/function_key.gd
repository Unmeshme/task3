extends BaseKey

#it can be icon + label class if I am feeling like it
export var texture_icon: Texture


onready var icon: TextureRect = $Panel/icon


#write code to make the icons work properly
#for certain icons

func _ready() -> void:
	._ready()
	#this is only if we use the gui but I am going to write it directly with code
	icon.texture = texture_icon

#lol rn fucntion key is just base key huh
func setup(p_data: Dictionary) -> void:
	.setup(p_data)
	#not here lol
