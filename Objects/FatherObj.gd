extends Area2D

func _ready():
	Events.connect("stop_level_timer", self, "_on_Stop_level_timer")
	Events.connect("start_level_timer", self, "_on_Start_level_timer")

func _on_FatherObj_body_entered(body):
	find_and_use_dialogue()

func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("FatherDialogue")
	
	if dialogue_player:
		dialogue_player.play()

func _on_Stop_level_timer():
	$FatherSpriteEnd.visible
	$FatherCollision.set_disabled(false)

func _on_Start_level_timer():
	$FatherCollision.set_disabled(true)
