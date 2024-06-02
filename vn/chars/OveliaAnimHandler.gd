extends Node

@export var o_NodePath: String = "res://vn/chars/Ovelia.tscn"

var scene = load(o_NodePath).resource_local_to_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func o_idle_anim():
	#scene = scene.get_node("AnimatedSprite3D")
	#scene.play("idle")
#
#func o_talk_anim():
	#scene = scene.get_node("AnimatedSprite3D")
	#scene.play("talk")
	
