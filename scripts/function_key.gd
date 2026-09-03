extends BaseKey

#it can be icon + label class if I am feeling like it
export var texture_icon: Texture


onready var icon: TextureRect = $Panel/icon



func _ready() -> void:
	._ready()
	icon.texture = texture_icon
