extends KinematicBody2D

const PlayerBullet = preload("res://Player/PlayerBullet.tscn")
const JumpEffect = preload("res://Effects/JumpEffect.tscn")

onready var player_sprite = $PlayerSprite
onready var muzzle = $PlayerSprite/PlayerGun/Sprite/Position2D
onready var player_gun = $PlayerSprite/PlayerGun
onready var jump_sound = $JumpSound
onready var player_anim = $PlayerAnim

export (int) var MAX_SPEED = 60
export (int) var ACCELERATION = 512
export (int) var GRAVITY = 200
export (float) var FRICTION = 0.25
export (int) var JUMP_FORCE = 100
export (int) var MAX_SLOPE_ANGLE = 46
export (int) var BULLET_SPEED = 250

var motion = Vector2.ZERO
var snap_vector = Vector2.ZERO
var double_jump = true
var player_shoots = 0

func _ready():
	Events.connect("bullet_destroyed", self, "on_Events_bullet_destroyed")

func _physics_process(delta):
	var x_input = get_x_input()
	apply_x_force(x_input, delta)
	apply_friction(x_input)
	apply_gravity(delta)
	update_snap_vector()
	jump_check()

	update_animations(x_input)
	
	move()
	
	if Input.is_action_just_pressed("fire") and player_shoots <= 2:
		fire_bullet()

func fire_bullet():
	var bullet = Utils.instance_scene_on_main(PlayerBullet, muzzle.global_position)
	bullet.velocity = Vector2.RIGHT.rotated(player_gun.rotation) * BULLET_SPEED
	bullet.velocity.x *= player_sprite.scale.x
	player_shoots += 1

func get_x_input():
	var x_input
	x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return x_input

func apply_x_force(x_input, delta):
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

func apply_friction(x_input):
	if x_input == 0:
		motion.x = lerp(motion.x, 0, FRICTION)

func apply_gravity(delta):
	motion.y += GRAVITY * delta
	motion.y = min(motion.y, JUMP_FORCE)

func jump_check():
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			Utils.instance_scene_on_main(JumpEffect, position)
			jump_sound.play()
			motion.y = -JUMP_FORCE
			snap_vector = Vector2.ZERO
	else:
		if Input.is_action_just_released("jump") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		if Input.is_action_just_pressed("jump") and double_jump == true:
			motion.y = 0
			motion.y -= JUMP_FORCE*.80
			double_jump = false

func update_snap_vector():
	if is_on_floor():
		snap_vector = Vector2.DOWN

func update_animations(x_input):
	player_sprite.scale.x = sign(get_local_mouse_position().x)
	if x_input == 0:
		player_anim.play("Idle")
	else:
		player_anim.play("Run")
	if not is_on_floor():
		player_anim.play("Jump")

func move():
	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	
	motion.y = move_and_slide_with_snap(motion, snap_vector * 4,Vector2.UP, true, 4, deg2rad(MAX_SLOPE_ANGLE)).y
	
	if was_in_air and is_on_floor():
		Utils.instance_scene_on_main(JumpEffect, position)
		double_jump = true

func on_Events_bullet_destroyed():
	player_shoots -= 1

func set_active(active):
	if active == false:
		player_anim.play("Idle")
		motion.x = 0
	
	set_physics_process(active)
	set_process(active)
	set_process_input(active)






