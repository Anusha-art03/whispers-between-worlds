extends Area2D

var player_near := false
var clue_open := false

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

		if clue_open:
			clue_panel.visible = false
			clue_open = false
			return

		clue_text.text = "\"Someone was trying to stitch it back together...\""
		clue_panel.visible = true
		clue_open = true
