extends Node2D

const ExplosionEffect = preload("res://Effects/ExplosionEffect.tscn")

var velocity = Vector2.ZERO


func _ready():
	set_process(false)

func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
	Events.emit_signal("bullet_destroyed")

func _on_Collision_body_entered(body):
	Utils.instance_scene_on_main(ExplosionEffect, position)
	queue_free()

func _on_Collision_area_entered(area):
	Utils.instance_scene_on_main(ExplosionEffect, position)
	queue_free()
