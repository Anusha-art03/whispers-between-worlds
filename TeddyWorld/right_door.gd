extends Area2D

var player_near := false
var door_open := false

@onready var interaction_label: Label = $InteractionLabel
@onready var wrong_sound: AudioStreamPlayer = $WrongDoorSound
@onready var clue_panel: Panel = $"../Act3UI/CluePanel"
@onready var clue_text: Label = $"../Act3UI/CluePanel/ClueText"


func _ready():
	interaction_label.visible = false
	clue_panel.visible = false

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.name == "Player":
		player_near = true
		interaction_label.visible = true


func _on_body_exited(body):
	if body.name == "Player":
		player_near = false
		interaction_label.visible = false


func _unhandled_input(event):
	if not player_near:
		return

	if event is InputEventKey and event.pressed and event.keycode == KEY_E:

		if door_open:
			return

		door_open = true
		interaction_label.visible = false

		wrong_sound.play()

		var player = get_tree().get_first_node_in_group("player")

		if player:
			var camera = player.get_node_or_null("Camera2D")

			if camera:
				camera.shake()

		clue_text.text = "\"You were never supposed to leave.\""
		clue_panel.visible = true
