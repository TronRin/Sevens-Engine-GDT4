extends CharacterBody3D

@onready var animated_sprite_3d = $AnimatedSprite3D

@export var move_speed = 5.0
@export var attack_range = 1.3
const PLAYER = preload("res://scenes/players/player.tscn")

var health = 16

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("Player")
var dead = false

func _physics_process(_delta):
	if dead:
		return
	if player == null:
		return
	
	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	
	velocity = dir * move_speed
	move_and_slide()
	attempt_to_kill_player()

func attempt_to_kill_player():
	var dist_to_player = global_position.distance_to(player.global_position)
	if dist_to_player > attack_range:
		return
	var eye_line =  Vector3.UP * 1.5
	var query = PhysicsRayQueryParameters3D.create(global_position, player.global_position, 1)
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		player.kill()

func kill(dmg_amount):
	health -= dmg_amount
	if health <= 0:
		dead = true
		$DeathSound.play()
		animated_sprite_3d.play("Death")
		$CollisionShape3D.disabled = true
	else:
		return
