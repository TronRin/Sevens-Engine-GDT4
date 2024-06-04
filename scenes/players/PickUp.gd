extends Area3D

@onready var pickupper = $".".get_children()

func _physics_process(_delta):
	AreaChecker.emit_area_entered()

func get_0(number):
	number = 0
	number.get_0()
