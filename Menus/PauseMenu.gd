extends Control

var paused = false setget set_paused

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		self.paused = !paused


func set_paused(value):
	paused = value
	get_tree().paused = paused
	visible = paused


func _on_ResumeButton_pressed():
	self.paused = false


func _on_MainMenuButton_pressed():
	get_tree().reload_current_scene()
	self.paused = false
	get_tree().change_scene("res://Menus/StartMenu.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
