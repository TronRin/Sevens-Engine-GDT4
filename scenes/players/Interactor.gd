extends RayCast3D

@onready var interactor = $"..".get_children()


#Called every frame. 'delta' is the elapsed time since the previous frame.
func check_interaction():
	for ray in interactor:
		if ray.is_colliding() and ray.get_collider().has_method("interact"):
			ray.get_collider().interact()


func _process(delta):
	if Input.is_action_just_pressed("use"):
		check_interaction()
	
	#if self.is_colliding():
		#if coll.is_in_group("Interactable"):
			#if Input.is_action_just_pressed("use"):
				#coll.Interact()
	#else:
		#return
