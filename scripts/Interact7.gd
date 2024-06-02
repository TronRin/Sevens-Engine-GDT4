extends Node3D
#
#const INTERACT_RANGE = 2.0 # adjust this value to change the interaction range
#const USE_INPUT_ACTION = "use" # set this to your custom input action name
#
#var interactable_objects = []
#var interactable_npcs = []
#
#func _ready():
	## add objects and npcs that can be interacted with here
	## for example:
	##interactable_objects.append($Object1)
	##interactable_objects.append($Object2)
	#
	#interactable_npcs.append($"../Ovelia")
	##interactable_npcs.append($NPC2)
#
#func _process(delta):
	## check if the player is close to an interactable object or npc
	#for obj in interactable_objects:
		#if is_close_to(obj) and Input.is_action_just_pressed(USE_INPUT_ACTION):
			#interact_with_object(obj)
	#
	#for npc in interactable_npcs:
		#if is_close_to(npc) and Input.is_action_just_pressed(USE_INPUT_ACTION):
			#interact_with_npc(npc)
#
#func is_close_to(node: StaticBody3D) -> bool:
	#return (node.transform.origin - self.get_global_position()).length() <= INTERACT_RANGE
#
#func interact_with_object(obj: Object):
	## implement object-specific interaction logic here
	#print("Interacting with object:", obj)
#
#var npc_functions = {
	#"misso": "talk_with_o"
	##"dude": "talk_with_dude",
	##"lady": "talk_with_lady"
#}
#func interact_with_npc(npc: StaticBody3D):
	#if npc_functions.has(npc.name):
		#npc.call(npc_functions[npc.name])
	#
