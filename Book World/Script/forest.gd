extends Node2D

@onready var dialogue_box: PanelContainer = $Player/DialogueBox
@onready var dialogue_label: Label = $Player/DialogueBox/DialogueLabel
@onready var dim_screen: ColorRect = $DialogueUI/DimScreen

var dialogue_active := false
var whisper_position := Vector2(-150, 50)
var whisper_distance := 80.0
var whisper_finished := false

func _process(_delta):
	if dialogue_active or whisper_finished:
		return

	var player_position = $Player.position

	if player_position.distance_to(whisper_position) < whisper_distance:
		start_whisper()
		

func _ready():
	
	# Dialogue is hidden when the scene starts.
	dialogue_box.hide()
	dim_screen.hide()


# Call this function when the player reaches the jungle/whisper area.
func start_whisper():
	if dialogue_active:
		return

	dialogue_active = true

	dim_screen.show()
	dialogue_box.show()

	dialogue_label.text = "You're not supposed to be here."

	await get_tree().create_timer(2.5).timeout

	dialogue_label.text = "But perhaps... you're the one\nwe've been waiting for."

	await get_tree().create_timer(3.0).timeout

	dialogue_box.hide()
	dim_screen.hide()
	dialogue_active = false
	whisper_finished = true

	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Book World/Scene/Village.tscn")
