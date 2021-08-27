extends Control

onready var level_01_label = $Labels/Level01Time
onready var level_02_label = $Labels/Level02Time
onready var level_03_label = $Labels/Level03Time

onready var anim_thanks = $CanvasLayer/AnimationPlayer

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	level_01_label.text = "Level 01 - " + Utils.level_time[0]
	level_02_label.text = "Level 02 - " + Utils.level_time[1]
	level_03_label.text = "Level 03 - " + Utils.level_time[2]

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://Menus/StartMenu.tscn")


func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://Levels/Level01.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()

