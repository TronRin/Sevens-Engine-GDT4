extends CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func interact():
	dynmusictest()
	
func dynmusictest():
	if Dialogic.current_timeline != null:
		return
	Dialogic.start("dynmustest")
	
