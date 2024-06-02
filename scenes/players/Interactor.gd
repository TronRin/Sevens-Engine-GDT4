extends RayCast3D

@onready var interactor = $"..".get_children()
var dialog = false
#Called every frame. 'delta' is the elapsed time since the previous frame.
func check_interaction(_delta):
	for ray in interactor:
		if ray.is_colliding() and ray.get_collider().has_method("interact"):
			ray.get_collider().interact()
			dialog = true

func _physics_process(_delta):
	if Input.is_action_just_pressed("use") and Dialogic.current_timeline == null and dialog == false:
		check_interaction(_delta)
	if Input.is_action_just_pressed("use") and dialog == true and Dialogic.current_timeline == null:
		check_interaction(_delta)
		#add_child(timer)
		#timer.wait_time = 10.5
		#timer.one_shot = true
		#timer.start()
		#timer.timeout.connect(Callable(self, "_on_timer_timeout"))
		#
#
#func _on_timer_timeout(_delta):
	#check_interaction(_delta)
	#dialog = false
	#if self.is_colliding():
		#if coll.is_in_group("Interactable"):
			#if Input.is_action_just_pressed("use"):
				#coll.Interact()
	#else:
		#return

