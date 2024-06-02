extends StaticBody3D
@export var key_name = ""
var talked_to_o = false 
var tbrush_complete = false
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
	if not has_key(key_name):
		# check if a dialog is already running
		if Dialogic.current_timeline != null:
			return
		Dialogic.start('missotalk1')
		get_viewport().set_input_as_handled()
		print("Talked with O, and accepted quest!!!")
	elif has_key(key_name):
		if Dialogic.current_timeline != null:
			return
		Dialogic.start('missotalk1_tbrushget')
		get_viewport().set_input_as_handled()
		tbrush_complete = true
		print("Gave that bitch the Toilet Brush!")
		if tbrush_complete == true:
			if Dialogic.current_timeline != null:
				return
			Dialogic.start('missotalk1_tbrushcomplete')
			get_viewport().set_input_as_handled()		
	#if Dialogic.connect("o_talk", Callable()):
		#$AnimatedSprite3D.play("talk")
	#elif Dialogic.connect("o_idle", Callable()):
		#$AnimatedSprite3D.play("idle")
		#
