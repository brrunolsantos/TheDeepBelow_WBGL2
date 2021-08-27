extends CanvasLayer

export (String, FILE, "*.json") var dialogue_file

onready var rich_text_name = $NinePatchRect/RichTextName
onready var rich_text_dialogue = $NinePatchRect/RichTextDialogue
onready var nine_path_rect = $NinePatchRect

var dialogues = []
var current_dialogue_id = 1
var is_dialogue_active = false
var dialogue_done = false

func _ready():
	nine_path_rect.visible = false

func play():
	if is_dialogue_active:
		return
	
	
	dialogues = load_dialogue()
	
	is_dialogue_active = true
	turn_off_player()
	nine_path_rect.visible = true
	
	current_dialogue_id = -1
	next_line()

func _input(event):
	if not is_dialogue_active:
		return
	
	if event.is_action_pressed("game_usage"):
		next_line()

func next_line():
	current_dialogue_id += 1
	
	if dialogue_done:
		current_dialogue_id = len(dialogues)
	
	if current_dialogue_id >= len(dialogues):
		is_dialogue_active = false
		nine_path_rect.visible = false
		dialogue_done = true
		turn_on_player()
		Events.emit_signal("start_level_timer")
		return
	
	rich_text_name.text = dialogues[current_dialogue_id]['name']
	rich_text_dialogue.text = dialogues[current_dialogue_id]['text']

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func turn_on_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func turn_off_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)





