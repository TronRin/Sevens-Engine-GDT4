extends Node3D

func _ready():
	MusicManagerHandler.add_music_layer("arp", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_ARP.ogg"))
	MusicManagerHandler.add_music_layer("bass", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_BASS.ogg"))
	MusicManagerHandler.add_music_layer("cello", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_CELLO.ogg"))
	MusicManagerHandler.add_music_layer("taiko", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TAIKO.ogg"))
	MusicManagerHandler.add_music_layer("timpani", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TIMPANI.ogg"))
	
	#MusicManager.add_music_layer("arp", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_ARP.wav"))
	#MusicManager.add_music_layer("bass", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_BASS.wav"))
	#MusicManager.add_music_layer("cello", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_CELLO.wav"))
	#MusicManager.add_music_layer("taiko", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TAIKO.wav"))
	#MusicManager.add_music_layer("timpani", load("res://sounds/BGM/dynmustest/BGM_LVL01_CALM_PT1_TIMPANI.wav"))
