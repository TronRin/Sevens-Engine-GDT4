extends Node3D

func _ready():
	
	#MusicManager.add_music_layer("arp", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_ARP.wav"))
	#MusicManager.add_music_layer("bass", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_BASS.wav"))
	#MusicManager.add_music_layer("cello", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_CELLO.wav"))
	#MusicManager.add_music_layer("taiko", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TAIKO.wav"))
	#MusicManager.add_music_layer("timpani", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TIMPANI.wav"))
	MusicManagerHandler.test_layers()
	MusicManagerHandler.set_music_layer_volume("basic", -3.5, 0.0, 0.0)
