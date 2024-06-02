extends Node3D

@export var player_character: CharacterBody3D
@export var enemy_character: CharacterBody3D
@export var menu: Control
@export var attack_button: Button
@export var run_button: Button

var current_turn = "player"


func _ready():
	attack_button.pressed.connect(Callable(self, "_on_attack_button_pressed_proxy"))
	run_button.pressed.connect(Callable(self, "_on_run_button_pressed"))
	menu.hide()

func _physics_process(_delta):
	if current_turn == "player":
		menu.show()
	else:
		menu.hide()
		enemy_character.approach()
		enemy_character.e_attack(player_character)
		switch_turn()

func player_attack(delta):
	player_character.approach(delta)
	player_character.p_attack(enemy_character)
	player_character.returning(delta)
	#player_character.return_to_original_position(delta)  # Move back to the original position
	switch_turn()
	

func _on_attack_button_pressed_proxy():
	_on_attack_button_pressed(get_process_delta_time())

func _on_attack_button_pressed(delta):
	player_attack(delta)  # Move back to the original position
	switch_turn()

func _on_run_button_pressed():
	get_tree().change_scene("res://world.tscn")

func switch_turn():
	if current_turn == "player":
		current_turn = "enemy"
	else:
		current_turn = "player"
