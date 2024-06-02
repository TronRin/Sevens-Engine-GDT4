extends Node
# Usage example in a game scene

@onready var quest_system = load("res://quests/QuestSystem.gd").new()
@onready var Quest = load("res://quests/Quest.gd").new()
func _ready():
	# Creating a new quest
	var quest = Quest.new("Find the Magic Sword", "Retrieve the Magic Sword from the ancient ruins.", ["Go to the ancient ruins.", "Defeat the guardian.", "Take the Magic Sword."], "A powerful magic sword.")

	# Adding the quest to the quest system
	quest_system.add_quest(quest)

	# Updating quest objectives
	#if player_reached_ancient_ruins():
		#quest_system.update_quest_objective("Find the Magic Sword", true)
	#if player_defeated_guardian():
		#quest_system.update_quest_objective("Find the Magic Sword", true)
	#if player_took_magic_sword():
		#quest_system.update_quest_objective("Find the Magic Sword", true)

	# Checking if the quest is completed
	if quest_system.is_quest_completed("Find the Magic Sword"):
		print("Quest completed! You have obtained the Magic Sword.")
