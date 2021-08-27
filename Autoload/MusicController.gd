extends Node

var MainMusic = load("res://Assets/MainMusic.wav")

onready var music_node = $Music

func _ready():
	pass

func play_music():
	music_node.stream = MainMusic
	music_node.play()

func _on_Music_finished():
	yield(get_tree().create_timer(2.0),"timeout")
	play_music()
