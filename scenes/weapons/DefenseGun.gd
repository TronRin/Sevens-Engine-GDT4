extends Node3D

@onready var defense_gun_anim = $CanvasLayer/GunBase/DefenseGun2D/DefenseGunAnim
@onready var gun_rays = $GunRays.get_children()
@onready var shoot_sound = $ShootSound
@onready var ray_cast_3d = $GunRays/RayCast3D
@onready var flash = preload("res://scenes/special/muzzle_flash.tscn")


var damage = 8
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	defense_gun_anim.play("DefenseGunIdle")

func check_hit():
	for ray in gun_rays:
		if ray.is_colliding() and ray.get_collider().has_method("kill"):
			ray.get_collider().kill(damage)

func make_flash():
	var f = flash.instantiate()
	add_child(f)

func _process(_delta):
	if Input.is_action_just_pressed("shoot") and can_shoot:
		defense_gun_anim.play("DefenseGunShoot")
		shoot_sound.play()
		make_flash()
		check_hit()
		can_shoot = false
		
		await(defense_gun_anim.animation_finished)
		can_shoot = true
		defense_gun_anim.play("DefenseGunIdle")
		
		
