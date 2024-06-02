extends DamageCalculator

@export var health = 80
@export var force_points = 15
@export var agility = 12
@export var attack = 15
@export var defense = 8
@export var luck = 3

enum State {
	IDLE,
	APPROACHING,
	ATTACKING,
}

var state = State.IDLE

func _process(delta):
	if health <= 0:
		get_tree().change_scene("path/to/victory/scene.tscn")

func approach():
	state = State.APPROACHING
	# Add code to move the enemy character towards the player character

func e_attack(player):
	if state == State.APPROACHING:
		state = State.ATTACKING
		var damage = calculate_damage(self, player)
		player.health -= damage
		print("Enemy dealt ", damage, " damage to the player.")
