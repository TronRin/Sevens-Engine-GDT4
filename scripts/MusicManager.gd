##MusicManager.gd (autoload script) old
#
#extends Node
#
#@onready var music_layers = {}
#
#var audio_stream_player
#
#var current_music_state = {}
#
#var audio_stream_players = []
#
#func _ready():
	#for i in range(16):
		##audio_stream_player = AudioStreamPlayer.new()
		##add_child(audio_stream_player)
		##audio_stream_players.append(audio_stream_player)
		##audio_stream_player.stream = music_layers[]
	#pass
	#
#
#func add_music_layer(layer_id, song_resource, volume = -100):
	#music_layers[layer_id] = {
		#"song": song_resource,
		#"volume": volume,
		#"playing": false,
		#"position": 0.0
	#}
#
#
#func play_music_layer(layer_id):
	#audio_stream_player = AudioStreamPlayer.new()
	#add_child(audio_stream_player)
	#audio_stream_players.append(audio_stream_player)
	#var layer = music_layers[layer_id]
	#layer.playing = true
	#var current_position = 0.0
	#for audio_stream_player in audio_stream_players:
		#if audio_stream_player.playing:
			#current_position = audio_stream_player.get_playback_position()
			#break
	#layer.position = current_position
	#var audio_stream_player = audio_stream_players.pop_back()
	#audio_stream_player.set_bus("BGM")
	#print(audio_stream_player.get_bus(), music_layers)
	#audio_stream_player.stream = layer.song
	#audio_stream_player.volume_db = layer.volume
	#audio_stream_player.seek(layer.position)
	#audio_stream_player.play()
#
#
#func stop_music_layer(layer_id):
	#if music_layers.has(layer_id):
		#var layer = music_layers[layer_id]
		#layer.playing = false
		#for audio_stream_player in audio_stream_players:
			#if audio_stream_player.stream == layer.song:
				#audio_stream_player.stop()
				#audio_stream_players.erase(audio_stream_player)
				#break
#
#func _process(delta):
	#pass
	#for layer in music_layers.values():
		#if layer.playing:
			#layer.position += delta
			#if layer.position >= layer.song.get_length():
				#layer.position = 0.0
			#for audio_stream_player in audio_stream_players:
				#if audio_stream_player.stream == layer.song:
					#audio_stream_player.seek(layer.position)
					#break
#
#func get_current_position():
	#return audio_stream_players[0].get_playback_position()
#
#func set_music_layer_volume(layer_id, volume: int):
	#if music_layers.has(layer_id):
		#var layer = music_layers[layer_id]
		#if audio_stream_player.stream == layer.song:
			#audio_stream_player.volume_db = volume
			#print("CURRENT VOLUME: ", volume)
#
#
##func set_music_layer_volume(layer_id, volume):
	##if music_layers.has(layer_id) and music_layers.has(volume):
		##music_layers[volume].volume = volume
		##for audio_stream_player in audio_stream_players:
			##if audio_stream_player.stream == music_layers[layer_id].song:
				##audio_stream_player.volume_db = volume
				##break
#
### We now set functions to load and then play layers in a level. One function per level.
#func test_layers():
	#MusicManagerHandler.add_music_layer("arp", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_ARP.ogg"), -80.0)
	#MusicManagerHandler.add_music_layer("bass", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_BASS.ogg"), -80.0)
	#MusicManagerHandler.add_music_layer("cello", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_CELLO.ogg"), -80.0)
	#MusicManagerHandler.add_music_layer("taiko", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TAIKO.ogg"), -80.0)
	#MusicManagerHandler.add_music_layer("timpani", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TIMPANI.ogg"), -80.0)
	#MusicManagerHandler.play_music_layer("arp")
	#MusicManagerHandler.play_music_layer("bass")
	#MusicManagerHandler.play_music_layer("cello")
	#MusicManagerHandler.play_music_layer("taiko")
	#MusicManagerHandler.play_music_layer("timpani")
#
###Example usage:
##func _ready():
	##add_music_layer("regular", load("res://music/regular.ogg"))
	##add_music_layer("npc", load("res://music/npc.ogg"))
##
##func _on_NPC_Talked():
	##play_music_layer("npc")
##
##func _on_Exploring_Location():
	##play_music_layer("regular")
extends Node

@onready var music_layers = {}

var audio_stream_players = {}

func _ready():
	pass

func add_music_layer(layer_id, song_resource, volume = -100.0):
	music_layers[layer_id] = {
		"song": song_resource,
		"volume": volume,
		"playing": false,
		"position": 0.0
	}

func play_music_layer(layer_id):
	var layer = music_layers[layer_id]
	layer.playing = true
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_players[layer_id] = audio_stream_player
	audio_stream_player.set_bus("BGM")
	audio_stream_player.stream = layer.song
	audio_stream_player.volume_db = layer.volume
	audio_stream_player.play()

func stop_music_layer(layer_id):
	if music_layers.has(layer_id):
		var layer = music_layers[layer_id]
		layer.playing = false
		if audio_stream_players.has(layer_id):
			audio_stream_players[layer_id].stop()
			audio_stream_players.erase(layer_id)

#func _process(delta):
	#for layer_id in music_layers:
		#var layer = music_layers[layer_id]
		#if layer.playing:
			#layer.position += delta
			#if layer.position >= layer.song.get_length():
				#layer.position = 0.0
			#if audio_stream_players.has(layer_id):
				#audio_stream_players[layer_id].seek(layer.position)

func get_current_position(layer_id):
	if audio_stream_players.has(layer_id):
		return audio_stream_players[layer_id].get_playback_position()
	return 0.0

func set_music_layer_volume(layer_id, volume: float, fade_in_time: float = 0.0, fade_out_time: float = 0.0):
	if music_layers.has(layer_id) and audio_stream_players.has(layer_id):
		var audio_stream_player = audio_stream_players[layer_id]
		var layer = music_layers[layer_id]
		layer.volume = volume
		if fade_in_time == 0.0:
			audio_stream_player.volume_db = volume
		else:
			#var start_volume = audio_stream_player.volume_db
			var tween = create_tween()
			tween.tween_property(audio_stream_player, "volume_db", volume, fade_in_time).set_ease(Tween.EASE_IN)
			tween.play()
		
		if fade_out_time > 0.0 and layer.playing:
			audio_stream_player.volume_db = volume
			#var start_volume = audio_stream_player.volume_db
			var tween = create_tween()
			tween.tween_property(audio_stream_player, "volume_db", -100.0, fade_out_time).set_ease(Tween.EASE_OUT)
			tween.play()
			#await get_tree().create_timer(1.0).timeout
			#audio_stream_player.stop()
			#audio_stream_players.erase(layer_id)
		print("CURRENT VOLUME: ", volume)
		
### We now set functions to load and then play layers in a level. One function per level.
func test_layers():
	MusicManagerHandler.add_music_layer("basic", load("res://sounds/BGM/lobby/bgm_lobby_basic.ogg"), -100.0)
	MusicManagerHandler.add_music_layer("misso", load("res://sounds/BGM/lobby/bgm_lobby_misso.ogg"), -100.0)
	MusicManagerHandler.add_music_layer("sales", load("res://sounds/BGM/lobby/bgm_lobby_sales.ogg"), -100.0)
	#MusicManagerHandler.add_music_layer("taiko", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TAIKO.ogg"), -80.0)
	#MusicManagerHandler.add_music_layer("timpani", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TIMPANI.ogg"), -80.0)
	MusicManagerHandler.play_music_layer("basic")
	MusicManagerHandler.play_music_layer("misso")
	MusicManagerHandler.play_music_layer("sales")
	#MusicManagerHandler.play_music_layer("taiko")
	#MusicManagerHandler.play_music_layer("timpani")
