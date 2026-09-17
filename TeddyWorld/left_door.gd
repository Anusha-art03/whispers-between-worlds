extends Area2D

@export var attic_scene_path: String = "res://Attic.tscn"

var player_near := false
var message_open := false

@onready var interaction_label: Label = $InteractionLabel
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

		# First E — show completion message
		if not message_open:
			message_open = true
			interaction_label.visible = false

			clue_text.text = "\"You found what was forgotten...\"\n\n\"Teddy is safe now.\""
			clue_panel.visible = true

			return

		# Second E — return to Attic
		get_tree().change_scene_to_file(attic_scene_path)
