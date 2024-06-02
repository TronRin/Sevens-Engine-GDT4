extends Node
# Usage example in a game scene
#@onready var quest_system = load("res://quests/QuestSystem.gd").instance()
#@onready var quest = load("res://quests/Quest.gd").instance()

func _init():
	if Engine.has_singleton("QuestList"):
		return
	Engine.register_singleton("QuestList", self)

func _ready():
	pass
func toilet_brush_q():
	QuestSystem.add_quest("quest_1", "The Toilet Brush", "Obtain a Toilet Brush from the Salesman.", {
		"checklist_1": [
			{"id": "item_1", "description": "Talk to Salesman.", "completed": false},
			{"id": "item_2", "description": "Return to O with the Toilet Brush.", "completed": false}
		]
	})

func tbrush_quest_completion():
	var quest_status = QuestSystem.get_quest_status("quest_1")
	if quest_status == "completed":
		print("Task is done! Now Hans can scrub away... I guess?")
	elif quest_status == "in_progress":
		print("Task in progress...")
	else:
		print("Task not started.")

