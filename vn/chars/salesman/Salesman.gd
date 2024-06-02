extends StaticBody3D

var talked_to_sales = false 

signal toilet_brush
@export var brushgot = ""
var after_tbrush = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func interact():
	
	talk_with_sales()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func talk_with_sales():
	if after_tbrush != true:
		# check if a dialog is already running
		if Dialogic.current_timeline != null:
			return
		Dialogic.start('sales_toiletbrush')
		get_viewport().set_input_as_handled()
		var key_name = "toilet_brush"
		Inventory.inventory.append(key_name)
		toilet_brush.emit()
		after_tbrush = true
		print("You have the fukken brush!!!")
	if after_tbrush == true:
		if Dialogic.current_timeline != null:
			return
		Dialogic.start('sales_aftertbrush')


