extends Node

# Dictionary to store all quests
var quests = {}

# Function to add a new quest
func add_quest(quest_id, quest_name, description, checklists):
	quests[quest_id] = {
		"name": quest_name,
		"description": description,
		"checklists": checklists,
		"status": "not_started"
	}

# Function to get the status of a quest
func get_quest_status(quest_id):
	if quests.has(quest_id):
		return quests[quest_id]["status"]
	else:
		return null

# Function to update the status of a quest
func update_quest_status(quest_id, status):
	if quests.has(quest_id):
		quests[quest_id]["status"] = status

# Function to check if a quest is completed
func is_quest_completed(quest_id):
	if quests.has(quest_id):
		return quests[quest_id]["status"] == "completed"
	else:
		return false

# Function to check if a quest is in progress
func is_quest_in_progress(quest_id):
	if quests.has(quest_id):
		return quests[quest_id]["status"] == "in_progress"
	else:
		return false

# Function to check if a quest is not started
func is_quest_not_started(quest_id):
	if quests.has(quest_id):
		return quests[quest_id]["status"] == "not_started"
	else:
		return false

# Function to check if a checklist item is completed
func is_checklist_item_completed(quest_id, checklist_id, item_id):
	if quests.has(quest_id):
		var checklist = quests[quest_id]["checklists"][checklist_id]
		if checklist.has(item_id):
			return checklist[item_id]["completed"]
	return false

# Function to update a checklist item
func update_checklist_item(quest_id, checklist_id, item_id, completed):
	if quests.has(quest_id):
		var checklist = quests[quest_id]["checklists"][checklist_id]
		if checklist.has(item_id):
			checklist[item_id]["completed"] = completed
			# Check if all items in the checklist are completed
			var all_completed = true
			for item in checklist.values():
				if!item["completed"]:
					all_completed = false
					break
			if all_completed:
				update_quest_status(quest_id, "completed")

func _ready():
	pass


#example:
#func _ready():
	#QuestSystem.add_quest("quest_1", "My First Quest", "Description of my first quest", {
		#"checklist_1": [
			#{"id": "item_1", "description": "Kill 10 monsters", "completed": false},
			#{"id": "item_2", "description": "Collect 5 coins", "completed": false}
		#],
		#"checklist_2": [
			#{"id": "item_3", "description": "Talk to NPC", "completed": false}
		#]
	#})
