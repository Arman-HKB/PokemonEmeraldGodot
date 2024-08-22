extends Area2D

@export_file("*.tscn") var path: String
@export var is_invisible: bool = false
@export var spawn_point: Vector2 = Vector2(0, 0)
@export var spawn_direction: Vector2 = Vector2(0, 0)
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	if is_invisible:
		$Sprite2D.texture = null
	sprite.visible = false
	var player = Utils.get_player()
	#player.player_entering_door_signal.connect(Callable(enter_door))
	#player.player_entered_door_signal.connect(Callable(close_door))
	player.connect("player_entering_door_signal", enter_door)
	#player.connect("player_entered_door_signal", close_door)

func enter_door():
	Utils.get_player().get_node("Sprite2D").visible = false
	Utils.get_player().set_physics_process(false)
	var player_pos = Utils.get_player().position
	if player_pos == Vector2(position.x, position.y+16) or player_pos == Vector2(position.x, position.y-16):
		animation_player.play("OpenDoor")

func close_door():
	animation_player.play("CloseDoor")
	
func door_closed():
	Utils.get_scene_manager().transition_to(path, spawn_point, spawn_direction)
