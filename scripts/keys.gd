extends Node3D
@onready var KEY = $"."
var is_picked_up = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func picked_up():
	if not is_picked_up:
		var key_name = "blue_key"
		Inventory.inventory.append(key_name)
		is_picked_up = true
	if is_picked_up:
		remove_key()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func remove_key():
	KEY.PROCESS_MODE_DISABLED
	KEY.visibility_changed
	pass
	
func _process(delta):
	pass
