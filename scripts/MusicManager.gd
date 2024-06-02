#MusicManager.gd (autoload script)

extends Node

var music_layers = {}


var current_music_state = {}


var audio_stream_players = []

func _ready():
	for i in range(10):
		var audio_stream_player = AudioStreamPlayer.new()
		add_child(audio_stream_player)
		audio_stream_players.append(audio_stream_player)
	

func add_music_layer(layer_id, song_resource, volume = 1.0):
	music_layers[layer_id] = {
		"song": song_resource,
		"volume": volume,
		"playing": false,
		"position": 0.0
	}


func play_music_layer(layer_id):
	if music_layers.has(layer_id):
		var layer = music_layers[layer_id]
		layer.playing = true
		var current_position = 0.0
		for audio_stream_player in audio_stream_players:
			if audio_stream_player.playing:
				current_position = audio_stream_player.get_playback_position()
				break
		layer.position = current_position
		var audio_stream_player = audio_stream_players.pop_front()
		audio_stream_player.stream = layer.song
		audio_stream_player.volume_db = layer.volume
		audio_stream_player.seek(layer.position)
		audio_stream_player.play()


func stop_music_layer(layer_id):
	if music_layers.has(layer_id):
		var layer = music_layers[layer_id]
		layer.playing = false
		for audio_stream_player in audio_stream_players:
			if audio_stream_player.stream == layer.song:
				audio_stream_player.stop()
				audio_stream_players.erase(audio_stream_player)
				break

func _process(delta):
	for layer_id in music_layers:
		var layer = music_layers[layer_id]
		if layer.playing:
			layer.position += delta
			if layer.position >= layer.song.get_length():
				layer.position = 0.0
			for audio_stream_player in audio_stream_players:
				if audio_stream_player.stream == layer.song:
					audio_stream_player.seek(layer.position)
					break

func get_current_position():
	return audio_stream_players[0].get_playback_position()


func set_music_layer_volume(layer_id, volume):
	if music_layers.has(layer_id):
		music_layers[layer_id].volume = volume
		for audio_stream_player in audio_stream_players:
			if audio_stream_player.stream == music_layers[layer_id].song:
				audio_stream_player.volume_db = volume
				break

##Example usage:
#func _ready():
	#add_music_layer("regular", load("res://music/regular.ogg"))
	#add_music_layer("npc", load("res://music/npc.ogg"))
#
#func _on_NPC_Talked():
	#play_music_layer("npc")
#
#func _on_Exploring_Location():
	#play_music_layer("regular")
