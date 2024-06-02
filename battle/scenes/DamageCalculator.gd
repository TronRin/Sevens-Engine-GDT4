extends Node

class_name DamageCalculator

func calculate_damage(attacker, defender):
	var damage = attacker.attack - defender.defense
	if randi_range(1, 100) > (100 - defender.luck):
		damage = 0
		print("Attack missed!")
	return damage
