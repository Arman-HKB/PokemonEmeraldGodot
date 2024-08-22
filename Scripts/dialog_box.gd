extends CanvasLayer

@export_file("*.json") var path: String

@onready var label = $Label
@onready var next_icon = $NextIcon
@onready var timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dialog: Array = []
var dialog_id = null
var current_line: int = 0
var active: bool = false
var complete: bool = false

func _ready():
	visible = false
	dialog = load_dialog()

func _input(event):
	if !active:
		return
	if event.is_action_pressed("z"):
		if complete:
			complete = false
			current_line += 1
			print_dialog()
		else:
			animation_player.play("RevealAll")
			
func line_complete():
	complete = true

func start(id):
	if active:
		return
	Utils.get_player().set_physics_process(false)
	dialog_id = id-1
	active = true
	visible = true
	print_dialog()

func hide_dialog():
	Utils.get_player().set_physics_process(true)
	visible = false

func load_dialog():
	var json_as_text = FileAccess.get_file_as_string(path)
	var json_as_dict = JSON.parse_string(json_as_text)
	return json_as_dict

func print_dialog():
	if current_line >= len(dialog[dialog_id]['dialogs']) :
		timer.start()
		current_line = 0
		hide_dialog()
		return
	if current_line+1 != len(dialog[dialog_id]['dialogs']):
		next_icon.visible = true
	else: next_icon.visible = false
	label.text = dialog[dialog_id]['dialogs'][current_line]
	animation_player.play("RevealLetterByLetter")

func _on_timer_timeout():
	active = false
