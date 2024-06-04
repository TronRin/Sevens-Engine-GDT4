extends StaticBody3D
@export var key_name = ""
var talked_to_o = false 
var tbrush_complete = false

var dialogue_map = {
	"no_key": {
		"dialogue": "missotalk1",
		"action": Callable(self, "_handle_no_key")
	},
	"has_key": {
		"dialogue": "missotalk1_tbrushget",
		"action": Callable(self, "_handle_has_key")
	},
	"tbrush_complete": {
		"dialogue": "missotalk1_tbrushcomplete",
		"action": Callable(self, "_handle_tbrush_complete")
	}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func has_key(key : String) -> bool:
	return key in Inventory.inventory
	
func interact():
		talk_with_o()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func talk_with_o():
	MusicManagerHandler.set_music_layer_volume("misso", $DynMusArea, -3.5, 2.2, 0.0)
	var current_state = get_current_state()
	if dialogue_map.has(current_state):
		var dialogue_data = dialogue_map[current_state]
		if Dialogic.current_timeline!= null:
			return
		Dialogic.start(dialogue_data["dialogue"])
		get_viewport().set_input_as_handled()
		dialogue_data["action"].call()

func get_current_state():
	if not has_key(key_name):
		return "no_key"
	elif has_key(key_name) and not tbrush_complete:
		return "has_key"
	if tbrush_complete:
		return "tbrush_complete"

func _handle_no_key():
	print("Talked with O, and accepted quest!!!")

func _handle_has_key():
	print("Gave that bitch the Toilet Brush!")
	EventManager.trigger_event("tbrush_event")
	tbrush_complete = true
	print("Player cleared the Toilet Brush Event! WOW!")

func _handle_tbrush_complete():
	return
#func talk_with_o():
	#if not has_key(key_name):
		## check if a dialog is already running
		#if Dialogic.current_timeline != null:
			#return
		#Dialogic.start('missotalk1')
		#get_viewport().set_input_as_handled()
		#print("Talked with O, and accepted quest!!!")
	#elif has_key(key_name):
		#if Dialogic.current_timeline != null:
			#return
		#Dialogic.start('missotalk1_tbrushget')
		#get_viewport().set_input_as_handled()
		#tbrush_complete = true
		#print("Gave that bitch the Toilet Brush!")
		#EventManager.trigger_event("tbrush_event")
		##Toilet Brush clear event trigger check hehe
	#if EventManager.has_event_been_triggered("tbrush_event"):
		#print("Player cleared the Toilet Brush Event! WOW!")
		#if Dialogic.current_timeline != null:
			#return
		#Dialogic.start('missotalk1_tbrushcomplete')
		#get_viewport().set_input_as_handled()		
	#if Dialogic.connect("o_talk", Callable()):
		#$AnimatedSprite3D.play("talk")
	#elif Dialogic.connect("o_idle", Callable()):
		#$AnimatedSprite3D.play("idle")
		#
