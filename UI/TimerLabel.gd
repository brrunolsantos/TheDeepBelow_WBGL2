extends Label

var time = 0
var timer_on = false
var time_passed

func _ready():
	Events.connect("start_level_timer", self, "_on_start_level_timer")
	Events.connect("stop_level_timer", self, "on_stop_level_timer")

func _process(delta):
	
	if timer_on:
		time += delta
	
	var mils = fmod(time, 1) * 1000
	var secs = fmod(time, 60)
	var mins = fmod(time, 60 * 60) / 60
	
	time_passed = "%02d : %02d : %02d" % [mins, secs, mils/10]
	text = time_passed

func _on_start_level_timer():
	timer_on = true

func on_stop_level_timer():
	Utils.save_time(time_passed)
	timer_on = false
	queue_free()

