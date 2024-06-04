extends Node

@onready var body = Area3D.new()

func ready():
	body.area_entered.connect(_on_area_entered)

func emit_area_entered():
	body.area_entered.emit()
			

func _on_area_entered():
	print("_on_area_entered working!!!")
	if body.get_parent().has_method("on_area_entered"):
		call("on_area_eneted")
