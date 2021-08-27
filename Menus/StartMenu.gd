extends Control

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	MusicController.play_music()


func _on_StartButton_pressed():
	get_tree().change_scene("res://Objects/Turorial.tscn")


func _on_MenuButton_pressed():
	get_tree().quit()
