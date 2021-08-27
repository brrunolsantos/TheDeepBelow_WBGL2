extends Area2D


func _on_PrisonDoor_body_entered(body):
	find_and_use_dialogue()

func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialogueDoor")
	Events.emit_signal("stop_level_timer")
	if dialogue_player:
		dialogue_player.play()

