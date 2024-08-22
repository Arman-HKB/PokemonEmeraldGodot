extends Area2D

@export var frame: int
@export var direction: Vector2

func _ready():
	pass

func _on_body_entered(_body):
	if Utils.get_player().direction == direction:
		Utils.get_scene_manager().get_node("Location/Frame").visible = true
		Utils.get_scene_manager().get_node("Location/Frame").frame = frame
		Utils.get_scene_manager().get_node("Location/AnimationPlayer").play("ShowFrame")
