extends Area3D

class_name Interactor

var controller: Node3D

func interact(interactable: Interactable) -> void:
	interactable.interacted.emit(self)

func focus(interactable: Interactable) -> void:
	interactable.focused.emit(self)
	
func unfocus(interactable: Interactable) -> void:
	interactable.unfocused.emit(self)

func get_closest_interactable() -> Interactable:
	var list: Array[Area3D] = get_overlapping_areas()
	var distance: float
	var closest_distance:float = INF
	var closest: Interactable = null
	
	for interactable in list:
		distance = interactable.global_position.distance_to(global_position)
		
		if distance < closest_distance:
			closest = interactable as Interactable
			closest_distance = distance
	
	return closest
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
