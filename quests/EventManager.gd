extends Node

# Dictionary to store all events
var events = {}

# Function to add a new event
func add_event(event_id, description):
	events[event_id] = {
		"description": description,
		"triggered": false
	}

# Function to trigger an event
func trigger_event(event_id):
	if events.has(event_id):
		events[event_id]["triggered"] = true

# Function to check if an event has been triggered
func has_event_been_triggered(event_id):
	if events.has(event_id):
		return events[event_id]["triggered"]
	else:
		return false

# Function to reset all events (e.g. when starting a new game)
func reset_events():
	for event in events.values():
		event["triggered"] = false

func _ready():
	# Initialize the event manager
	pass

## Example usage:
#To add a new event, you can use the following code:
#
#func _ready():
	#EventManager.add_event("event_id", "Your event description")
#
#To trigger an event, you can use the following code:
#
#func _on_eventCleared():
	#EventManager.trigger_event("event_id")
#
#To check if an event has been triggered, you can use the following code:
#
#func _process(delta):
	#if EventManager.has_event_been_triggered("event_id"):
		#print("Part 1 of the story has been cleared!")
#
#To reset all events when starting a new game, you can use the following code:
#
#func _on_NewGameStarted():
	#EventManager.reset_events()
