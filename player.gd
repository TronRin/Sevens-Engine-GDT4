extends CharacterBody3D

@onready var camera_3d = $Head/Camera3D
@onready var head = $Head
#@onready var gun = $Head/Camera3D/Gun

#@onready var defensegun = preload("res://scenes/weapons/DefenseGun.tscn")
#@onready var shotgun = preload("res://scenes/weapons/Shotgun.tscn")
@onready var key = preload("res://scenes/items/key.tscn")

var ust_act = Input.is_action_just_pressed("use")

var item_used = false

#var wpn_select = 0 #weapon number
#var weapons = ["DefenseGun", "Shotgun", "MiniGun"] #array of possible guns

# Movement
const MAX_VELOCITY_AIR = 0.6
const MAX_VELOCITY_GROUND = 6.0
const MAX_ACCELERATION = 10 * MAX_VELOCITY_GROUND
const GRAVITY = 15.34
const STOP_SPEED = 1.5
const JUMP_IMPULSE = sqrt(2 * GRAVITY * 0.85)
const PLAYER_WALKING_MULTIPLIER = 0.666

var direction = Vector3()
var friction = 4
var wish_jump
var walking = false

# Camera
var sensitivity = 0.05

#Additional Movement Stuff
const DASH_SPEED = 8.0

#Headbobbing shite
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

## Get the gravity from the project settings to be synced with RigidBody nodes. OLD DO NOT UNCOMMENT ONLY FOR REF
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#var can_shoot = true
var dead = false
var is_dashing = false

var finished_interaction = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CanvasLayer/DeathScreen/Panel/Button.button_up.connect(restart)

func _input(event):
	
	# Camera rotation
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_handle_camera_rotation(event)
	if Dialogic.current_timeline != null and finished_interaction == false:
		$"."._physics_process(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		finished_interaction = true
	else:
		return_control_event()

func return_control_event():
	if Dialogic.current_timeline == null and finished_interaction == true:
		$"."._physics_process(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		finished_interaction = false
	
	
func _handle_camera_rotation(event: InputEvent):
	# Rotate the camera based on the mouse movement
	rotate_y(deg_to_rad(-event.relative.x * sensitivity))
	$Head.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
	
	# Stop the head from rotating to far up or down
	$Head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-60), deg_to_rad(90))

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	#if Input.is_action_just_pressed("next weapon"):
		#if wpn_select < weapons.size()-1:
			#wpn_select += 1
			#weapon_select(weapons[wpn_select])
			##print("Gun: ", wpn_select)
		#else:
			#wpn_select = 0
			#weapon_select(weapons[wpn_select])
			##print("Shotgun: ", wpn_select)
#
	#if Input.is_action_just_pressed("previous weapon"):
		#if wpn_select > 0:
			#wpn_select -= 1
			#weapon_select(weapons[wpn_select])
			##print("Gun: ", wpn_select)
		#else:
			#wpn_select = 1
			#weapon_select(weapons[wpn_select])
			
			
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
	
	process_input(delta)
	process_movement(delta)
	
	# Headbobbing
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera_3d.transform.origin = _headbob(t_bob)
	
	##Handle running/dashing
	#if Input.is_action_pressed("dash"):
		#speed = DASH_SPEED
	#else:
		#speed = WALK_SPEED
	
	#General Movement OLD
	#var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if is_on_floor():
		#if direction:
			#velocity.x = direction.x * speed
			#velocity.z = direction.z * speed
		#else:
			#velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			#velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	#else:
		#velocity.x = lerp(velocity.x, direction.x * speed, delta * 5.0)
		#velocity.z = lerp(velocity.z, direction.z * speed, delta * 5.0)
	#


	move_and_slide()
	
func process_input(delta):
	direction = Vector3()
	
	if Dialogic.current_timeline == null:
		
		# Movement directions
		if Input.is_action_pressed("move_forward"):
			direction -= transform.basis.z
		elif Input.is_action_pressed("move_backward"):
			direction += transform.basis.z
		if Input.is_action_pressed("move_left"):
			direction -= transform.basis.x
		elif Input.is_action_pressed("move_right"):
			direction += transform.basis.x
	else:
		pass
		
	# Jumping
	wish_jump = Input.is_action_just_pressed("jump")
	
	# Walking
	walking = Input.is_action_pressed("walk")
	
func process_movement(delta):
	# Get the normalized input direction so that we don't move faster on diagonals
	var wish_dir = direction.normalized()

	if is_on_floor():
		# If wish_jump is true then we won't apply any friction and allow the 
		# player to jump instantly, this gives us a single frame where we can 
		# perfectly bunny hop
		if wish_jump:
			velocity.y = JUMP_IMPULSE
			# Update velocity as if we are in the air
			velocity = update_velocity_air(wish_dir, delta)
			wish_jump = false
		else:
			if walking:
				velocity.x *= PLAYER_WALKING_MULTIPLIER
				velocity.z *= PLAYER_WALKING_MULTIPLIER
			
			velocity = update_velocity_ground(wish_dir, delta)
	else:
		# Only apply gravity while in the air
		velocity.y -= GRAVITY * delta
		velocity = update_velocity_air(wish_dir, delta)

	# Move the player once velocity has been calculated
	move_and_slide()
	
func accelerate(wish_dir: Vector3, max_speed: float, delta):
	# Get our current speed as a projection of velocity onto the wish_dir
	var current_speed = velocity.dot(wish_dir)
	# How much we accelerate is the difference between the max speed and the current speed
	# clamped to be between 0 and MAX_ACCELERATION which is intended to stop you from going too fast
	var add_speed = clamp(max_speed - current_speed, 0, MAX_ACCELERATION * delta)
	
	return velocity + add_speed * wish_dir
	
func update_velocity_ground(wish_dir: Vector3, delta):
	# Apply friction when on the ground and then accelerate
	var speed = velocity.length()
	
	if speed != 0:
		var control = max(STOP_SPEED, speed)
		var drop = control * friction * delta
		
		# Scale the velocity based on friction
		velocity *= max(speed - drop, 0) / speed
	
	return accelerate(wish_dir, MAX_VELOCITY_GROUND, delta)
	
func update_velocity_air(wish_dir: Vector3, delta):
	# Do not apply any friction
	return accelerate(wish_dir, MAX_VELOCITY_AIR, delta)

#func weapon_select(wpn_name):
	#if wpn_name == "DefenseGun":
		#$Head/Camera3D/Gun.add_child(defensegun.instantiate(), true)
		#$Head/Camera3D/Gun.get_child(0).queue_free()
		#
	#if wpn_name == "Shotgun":
		#$Head/Camera3D/Gun.add_child(shotgun.instantiate(), true)
		#$Head/Camera3D/Gun.get_child(0).queue_free()
		#
	#if wpn_name == "MiniGun":
		#$Head/Camera3D/Gun.add_child(defensegun.instantiate(), true)
		#$Head/Camera3D/Gun.get_child(0).queue_free()

#func check_pickup_enetered():
	#for area in key:
		#$Items.add_child(key.instantiate(), true)
		#if area.is_colliding() and area.get_collider().has_method("picked_up"):
			#area.get_collider().picked_up()

func on_enter_area():
	print("Player entered the area!")

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
