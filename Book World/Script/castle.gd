extends Node2D

@onready var player = $Player
@onready var gate_point: Marker2D = $GatePoint

@onready var dialogue_box: PanelContainer = $Player/DialogueBox
@onready var dialogue_label: Label = $Player/DialogueBox/DialogueLabel
@onready var dim_screen: ColorRect = $DialogueUI/DimScreen

var gate_used := false
var gate_distance := 80.0


func _ready():
	dialogue_box.hide()
	dim_screen.hide()


func _process(_delta):
	if gate_used:
		return

	if player.position.distance_to(gate_point.position) < gate_distance:
		if Input.is_key_pressed(KEY_E):
			open_castle()


func open_castle():
	gate_used = true

	dim_screen.show()
	dialogue_box.show()

	dialogue_label.text = "Only the one who remembers may enter."

	await get_tree().create_timer(3.0).timeout

	dialogue_box.hide()
	dim_screen.hide()

	await get_tree().create_timer(1.0).timeout

	get_tree().change_scene_to_file(
		"res://Book World/Scene/PrincessRoom.tscn"
	)
