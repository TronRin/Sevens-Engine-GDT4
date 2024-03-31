extends StaticBody3D

@onready var entity_1_secret_door = $".."
@onready var door_anim = $"../AnimationPlayer"
@onready var doorsfx = $"../doorsfx"
var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
		door_anim.play("opened")
		doorsfx.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
