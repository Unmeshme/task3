extends BaseKey

#it can be icon + label class if I am feeling like it
export var texture_icon: Texture


onready var icon: TextureRect = $Panel/icon
#honestly we don't even do anything with it lol,..

func _ready() -> void:
	._ready()
	icon.texture = texture_icon
