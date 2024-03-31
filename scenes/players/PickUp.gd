extends RayCast3D

@onready var picker = $"..".get_children()

func _process(delta):
	for col in picker:
		if col.is_colliding() and col.get_collider().has_method("picked_up"):
				col.get_collider().picked_up()
