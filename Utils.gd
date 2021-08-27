extends Node

var level = 0

var level_time = ["","",""]

func instance_scene_on_main(scene, position):
	var main = get_tree().current_scene
	var instance = scene.instance()
	main.add_child(instance)
	instance.global_position = position
	return instance

func change_to_packed_scene(next_scene):
	get_tree().change_scene_to(next_scene)

func save_time(time):
	if level >= 3:
		level = 0
		return
	
	level_time[level] = str(time)
	level += 1
	
	
	
