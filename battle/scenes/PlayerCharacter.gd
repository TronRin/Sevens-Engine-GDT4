extends DamageCalculator

@export var health = 100
@export var force_points = 20
@export var agility = 15
@export var attack = 20
@export var defense = 10
@export var luck = 5

@export var mov_speed = 30.0
@export var stop_distance = 1.0

@export var target: CharacterBody3D

enum State {
	IDLE,
	APPROACHING,
	ATTACKING,
	RETURNING,
}

var state = State.IDLE
var original_position: Vector3

func _process(delta):
	if health <= 0:
		get_tree().change_scene("path/to/gameover/scene.tscn")

func approach(delta):
	state = State.APPROACHING
	original_position = self.transform.origin  # Store the original position

	# Calculate direction vector from current object to target object
	var direction = (target.transform.origin - self.transform.origin).normalized()

	# Move towards the target object
	self.transform.origin += direction * mov_speed * delta

	# Check if we're close enough to the target
	if self.transform.origin.distance_to(target.transform.origin) < stop_distance:
		state = State.ATTACKING

func p_attack(enemy):
	if state == State.ATTACKING:
		var damage = calculate_damage(self, enemy)
		enemy.health -= damage
		print("Player dealt ", damage, " damage to the enemy.")
		state = State.RETURNING

func returning(delta):
	if state == State.RETURNING:
		var direction = (original_position - self.transform.origin).normalized()
		self.transform.origin += direction * mov_speed * delta
		if self.transform.origin.distance_to(original_position) < stop_distance:
			state = State.IDLE


