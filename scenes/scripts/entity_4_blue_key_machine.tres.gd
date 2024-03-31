extends Node3D

@onready var secret_door1 = $"../secret_door"
@onready var door_anim = $"../secret_door/AnimationPlayer"
@onready var doorsfx = $"../secret_door/doorsfx"
@onready var access_denied = $"../secret_door/access_denied"
@onready var access_granted = $"../secret_door/access_granted"
#@onready var player = $Player

enum UnlockType { NONE, KEY, BUTTON } 
@export var unlock_type = UnlockType.NONE
@export var key_name = "" 
@export var button_node_path = "" 

var is_open = false


func _ready() -> void:
	pass

func interact():
	if is_open:
		access_denied.play()
	match unlock_type:
		UnlockType.NONE:
			if not is_open:
				_open_door()
		UnlockType.KEY:
			if has_key(key_name) and not is_open:
				_open_door()
			else:
				access_denied.play()
		UnlockType.BUTTON:
			_on_button_pressed()

func _open_door():
		access_granted.play()
		door_anim.play("opened")
		doorsfx.play()
		is_open = true

func _on_button_pressed():
	_open_door()

func has_key(key_name : String) -> bool:
	return key_name in Inventory.inventory
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
