extends Node3D

@onready var secret_door1 = $entity_1_secret_door
@onready var door_anim = $entity_1_secret_door/AnimationPlayer


var is_used: bool = false

func interact():
	used()

func used() -> void:
	door_anim.play("door_open")
