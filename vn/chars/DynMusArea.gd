extends Area3D

func _ready():
	$".".emit_signal("body_entered")
	print("you enter O's body")
