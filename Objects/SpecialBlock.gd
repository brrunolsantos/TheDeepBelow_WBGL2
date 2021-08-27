extends Area2D

const UpperPlatform = preload("res://Objects/UpSidePlataform.tscn")
const DownPlatform = preload("res://Objects/DownSidePlataform.tscn")
const LeftPlatform = preload("res://Objects/LeftSidePlataform.tscn")
const RightPlatform = preload("res://Objects/RightSidePlataform.tscn")
const SinglePlataform = preload("res://Objects/SinglePlataform.tscn")

enum PLATFORM_SIDE {UP_SIDE, DOWN_SIDE, LEFT_SIDE, RIGHT_SIDE, SINGLE_SIDE}

export (PLATFORM_SIDE) var platform_side

func _on_SpecialBlock_area_entered(area):
	match platform_side:
		0:
			Utils.instance_scene_on_main(UpperPlatform, position)
		1:
			Utils.instance_scene_on_main(DownPlatform, position)
		2:
			Utils.instance_scene_on_main(LeftPlatform, position)
		3:
			Utils.instance_scene_on_main(RightPlatform, position)
		4:
			Utils.instance_scene_on_main(SinglePlataform, position)
	
	visible = false
	yield(get_tree().create_timer(3.0), "timeout")
	visible = true # Replace with function body.
