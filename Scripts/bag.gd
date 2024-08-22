extends Node2D

@onready var bag_icon = $BagIcon
@onready var section_marker = $SectionMarker
@onready var left_arrow = $LeftSectionArrow
@onready var right_arrow = $RightSectionArrow
@onready var animation_player = $AnimationPlayer

func _ready():
	$ItemIcon.visible = true

var marker_positions = [Vector2(40, 24), Vector2(48, 24), Vector2(56, 24), Vector2(64, 24), Vector2(72, 24)]

func hide_arrows():
	left_arrow.visible = false
	right_arrow.visible = false

func show_arrows():
	left_arrow.visible = true
	right_arrow.visible = true
	animation_player.play("SectionArrowMovement")

func _unhandled_input(event):
	if event.is_action_pressed("ui_left"):
		if bag_icon.frame - 1 < 0:
			bag_icon.frame = 4
			section_marker.position = marker_positions[4]
		else: 
			bag_icon.frame -= 1
			section_marker.position = marker_positions[bag_icon.frame]
		animation_player.play("Previous")
	if event.is_action_pressed("ui_right"):
		if bag_icon.frame + 1 > 4:
			bag_icon.frame = 0
			section_marker.position = marker_positions[0]
		else: 
			bag_icon.frame += 1
			section_marker.position = marker_positions[bag_icon.frame]
		animation_player.play("Next")
