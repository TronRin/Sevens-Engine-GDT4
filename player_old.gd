extends CharacterBody3D

@onready var camera_3d = $Head/Camera3D
@onready var head = $Head
@onready var gun = $Head/Camera3D/Gun

@onready var defensegun = preload("res://scenes/weapons/DefenseGun.tscn")
@onready var shotgun = preload("res://scenes/weapons/Shotgun.tscn")
@onready var key = preload("res://scenes/items/key.tscn")

var ust_act = Input.is_action_just_pressed("use")

var item_used = false

var wpn_select = 0 #weapon number
var weapons = ["DefenseGun", "Shotgun", "MiniGun"] #array of possible guns

var speed
const WALK_SPEED = 5.0
const MOUSE_SENS = 0.01
const JUMP_VELOCITY = 4.5
const VERT_ROT_LIMIT = 90.0
const DASH_SPEED = 8.0

#Headbobbing shite
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var can_shoot = true
var dead = false
var is_dashing = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CanvasLayer/DeathScreen/Panel/Button.button_up.connect(restart)

func _input(event):
	#While we dead, we fucking don't do nothing.
	if dead:
		return
	if event is InputEventMouseMotion: #Mouselook
		head.rotate_y(-event.relative.x * MOUSE_SENS)
		camera_3d.rotate_x(-event.relative.y * MOUSE_SENS)
		#We clamp the value of camera rotation for out mouselook, so we don't SPIN out of control!
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-70), deg_to_rad(90))

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if Input.is_action_just_pressed("next weapon"):
		if wpn_select < weapons.size()-1:
			wpn_select += 1
			weapon_select(weapons[wpn_select])
			#print("Gun: ", wpn_select)
		else:
			wpn_select = 0
			weapon_select(weapons[wpn_select])
			#print("Shotgun: ", wpn_select)

	if Input.is_action_just_pressed("previous weapon"):
		if wpn_select > 0:
			wpn_select -= 1
			weapon_select(weapons[wpn_select])
			#print("Gun: ", wpn_select)
		else:
			wpn_select = 1
			weapon_select(weapons[wpn_select])
			#print("Shotgun: ", wpn_select)
	#if key.:
		#$Items.add_child(key.instantiate(), true)
		#if Area3D.is_colliding() and Area3D.get_collider().has_method("picked_up"):
			#Area3D.get_collider().picked_up()

	if dead:
		return

func _physics_process(delta):
	if dead:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle running/dashing
	if Input.is_action_pressed("dash"):
		speed = DASH_SPEED
	else:
		speed = WALK_SPEED
	
	#General Movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 5.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 5.0)
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera_3d.transform.origin = _headbob(t_bob)

	move_and_slide()
	
func weapon_select(wpn_name):
	if wpn_name == "DefenseGun":
		$Head/Camera3D/Gun.add_child(defensegun.instantiate(), true)
		$Head/Camera3D/Gun.get_child(0).queue_free()
		
	if wpn_name == "Shotgun":
		$Head/Camera3D/Gun.add_child(shotgun.instantiate(), true)
		$Head/Camera3D/Gun.get_child(0).queue_free()
		
	if wpn_name == "MiniGun":
		$Head/Camera3D/Gun.add_child(defensegun.instantiate(), true)
		$Head/Camera3D/Gun.get_child(0).queue_free()

#func check_pickup_enetered():
	#for area in key:
		#$Items.add_child(key.instantiate(), true)
		#if area.is_colliding() and area.get_collider().has_method("picked_up"):
			#area.get_collider().picked_up()

func _on_pickup_area_entered():
	pass

func restart():
	get_tree().reload_current_scene()

func kill():
	dead = true
	$CanvasLayer/DeathScreen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func _on_key_blue_key_signal():
	$"../Key".queue_free()
