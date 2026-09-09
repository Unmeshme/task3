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
	#now we also position and add stuff here:
	#lol we have the shift label
	shift_label = p_info.get("shift_label", "")
	#always above the current text
	on_shift_text.text = shift_label



func _on_Panel_gui_input(p_event: InputEvent) ->void:
	if p_event is InputEventMouseButton:
		if p_event.button_index == BUTTON_LEFT and p_event.pressed:
			if label_text.text == "":
				return
			else:
				print(label_text.text)
