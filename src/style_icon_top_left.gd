extends BaseKey


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var icon: TextureRect = $Panel/icon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func setup(p_data: Dictionary) -> void:
	.setup(p_data)
	
	if p_data.has("icon"):
		icon.texture = load(p_data.get("icon", ""))
