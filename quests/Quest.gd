extends Node
# Quest.gd

class QuestClass:
	var title = ""
	var description = ""
	var objectives = []
	var current_objective = 0
	var reward = ""
	var is_completed = false

	var instance = null

		
	func _init():
		if Engine.has_singleton("Quest"):
			return
		Engine.register_singleton("Quest", self)
		
	func quest_defaults(title, description, objectives, reward):
		self.title = title
		self.description = description
		self.objectives = objectives
		self.reward = reward

	func update_objective(objective_completed):
		if objective_completed:
			current_objective += 1
		if current_objective == objectives.size():
			is_completed = true
