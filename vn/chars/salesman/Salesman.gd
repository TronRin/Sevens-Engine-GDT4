extends StaticBody3D

var talked_to_sales = false 

signal toilet_brush
@export var brushgot = ""
var after_tbrush = false

var dialogue_map = {
	"has_no_tbrush": {
		"dialogue": "sales_toiletbrush",
		"action": Callable(self, "_handle_no_tbrush")
	},
	"has_tbrush": {
		"dialogue": "sales_aftertbrush",
		"action": Callable(self, "_handle_has_tbrush")
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if Dialogic.timeline_ended:
		MusicManagerHandler.set_music_layer_volume("sales", -3.5, 0.0, 10.5)

func interact():
	
	talk_with_sales()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func talk_with_sales():
	MusicManagerHandler.set_music_layer_volume("sales", -3.5, 2.2, 0.0)
	var current_state = get_current_state()
	if dialogue_map.has(current_state):
		var dialogue_data = dialogue_map[current_state]
		if Dialogic.current_timeline!= null:
			return
		Dialogic.start(dialogue_data["dialogue"])
		get_viewport().set_input_as_handled()
		dialogue_data["action"].call()
		

func get_current_state():
	if not after_tbrush:
		return "has_no_tbrush"
	elif after_tbrush:
		return "has_tbrush"

func _handle_no_tbrush():
	print("Talked with Salesman!")
	
	after_tbrush = true
	var key_name = "toilet_brush"
	Inventory.inventory.append(key_name)
	
func _handle_has_tbrush():
	print("You already have the Toilet Brush!")
	


