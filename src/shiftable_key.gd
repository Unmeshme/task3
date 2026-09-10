extends BaseKey

export var shift_label: String = ""

onready var on_shift_text: Label = $Panel/shift_label



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setup(p_info: Dictionary) -> void:
	.setup(p_info)
	shift_label = p_info.get("shift_label", "")
	on_shift_text.text = shift_label


