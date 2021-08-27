extends Area2D

export(PackedScene) var next_scene

onready var anim_player = $AnimationPlayer

func _on_SupplyBox_body_entered(body):
	anim_player.play("Fade_Out")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
