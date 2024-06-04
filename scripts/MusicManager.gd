extends Node
## MusicManager.gd
## It's the very core of the (officially named) "Layers of O Music System"!
## Or O-LAyers for short... not like it matters lmao.
## Just set it up on an empty "node" inside a scene then load that scene as an 'autoload' and you're good to go.
## Then it's up to you if you want to do it how I've done it here or do it differently.
## What works for me, might not for you.
## 
## TL;DR: It loads instances of "AudioStreamPlayer' equal to the amount of "music_layers" you add.
## Then you can manage at what volume the music starts and how quickly it fades in or out.
## 
## Example usage, to get you quickly started:
## 
## Adding a music "layer" is done like so:
## [codeblock]
## func _ready():
##     add_music_layer("example_layer", load("res://path/to/yer/music.extension"), volume)
## [/codeblock]
## Where "example_layer" is the name you must give to your layer, keep it simple. 
## Then we add the path to audio file, all that Godot supports out of the box will work of course.
## Lastly is the "volume", which is self explanatory.
## If you want the layer to start muted, simply use a value like '-80.0', which is the minimum Godot allows.
## So in practice:
## [codeblock]
## func _ready():
##     add_music_layer("sad_violin", load("res://bgm/bgm_sad_violin.ogg"), -80.0)
## [/codeblock]
## WARNING: Don't set 'volume' too high on positive values. In fact, unless your music is very VERY quiet
##          I beg of you, set the 'volume' to a value like: '0.0' and then increase or decrease from there as needed.
##          Just understand that the higher you go, the more you're likely to ruin your speakers or blow your ear drums out.
##          It's by design btw. Feel free to look at the AudioStreamPlayer definition in official Godot 4 Docs.
## Once you have all your layers prepped one way or another, you can then control how they "enter".
## And how you manage playing, muting and unmuting layers goes like this:
## [codeblock]
## func _ready():
##     play_music_layer("example_layer")
##     set_music_layer_volume("example_layer", volume, fade_in_time, fade_out_time)
## [/codeblock]
## I think it's self explanatory. fade_in_time and fade_out_time are floats, just like volume btw.
## If you set any of them to '0.0' then the change will happen instantly. No fade in or out then.
## Le Practical Example:
## [codeblock]
## func mr_dingus_has_a_funi_pingus():
##     play_music_layer("mrdingus")
##     set_music_layer_volume("mrdingus", -2.0, 3.5, 0.0)
## 
## func mr_pingus_leaves():
##     set_music_layer_volume("mrdingus", -2.0, 0.0, -3.8)
## [/codeblock]
## 
## That's it. I guess. There's still some shit I haven't arrived at, but it's entirely perfectly usable.
## 
## Especially for me, since this is all I neeed. YAY!

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
			var tween = create_tween()
			tween.tween_property(audio_stream_player, "volume_db", volume, fade_in_time).set_ease(Tween.EASE_OUT)
			tween.play()
		
		if fade_out_time > 0.0 and layer.playing:
			audio_stream_player.volume_db = volume
			var tween = create_tween()
			tween.tween_property(audio_stream_player, "volume_db", -80.0, fade_out_time).set_ease(Tween.EASE_OUT)
			tween.play()
		print("CURRENT VOLUME: ", volume)
		

## Rainbow Hotel - Lobby -
func lobby_music():
	add_music_layer("basic", load("res://sounds/BGM/lobby/bgm_lobby_basic.ogg"), -100.0)
	add_music_layer("misso", load("res://sounds/BGM/lobby/bgm_lobby_misso.ogg"), -100.0)
	add_music_layer("sales", load("res://sounds/BGM/lobby/bgm_lobby_sales.ogg"), -100.0)
	play_music_layer("basic")
	play_music_layer("misso")
	play_music_layer("sales")
