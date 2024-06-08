extends Node3D

func _ready():
	
	#MusicManager.add_music_layer("arp", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_ARP.wav"))
	#MusicManager.add_music_layer("bass", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_BASS.wav"))
	#MusicManager.add_music_layer("cello", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_CELLO.wav"))
	#MusicManager.add_music_layer("taiko", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TAIKO.wav"))
	#MusicManager.add_music_layer("timpani", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TIMPANI.wav"))
	MusicManagerHandler.add_music_layer("basic", load("res://sounds/BGM/lobby/bgm_lobby_basic.ogg"), -100.0)
	MusicManagerHandler.add_music_layer("misso", load("res://sounds/BGM/lobby/bgm_lobby_misso.ogg"), -100.0)
	MusicManagerHandler.add_music_layer("sales", load("res://sounds/BGM/lobby/bgm_lobby_sales.ogg"), -100.0)
	
	MusicManagerHandler.play_music_layer("basic")
	MusicManagerHandler.play_music_layer("misso")
	MusicManagerHandler.play_music_layer("sales")
	MusicManagerHandler.set_music_layer_volume("basic", -2.5, 0.0, 0.0)
	
	#AreaChecker.add_music_area("misso", preload("res://vn/chars/Ovelia.tscn"))
	#AreaChecker.load_music_area("misso")
