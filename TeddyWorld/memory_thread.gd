extends Area2D

var player_near := false
var memory_open := false
var memory_collected := false

@onready var interaction_label: Label = $InteractionLabel
@onready var memory_panel: Panel = $"../MemoryUI/MemoryPanel"
@onready var memory_text: Label = $"../MemoryUI/MemoryPanel/MemoryText"



func _ready():
	interaction_label.visible = false
	memory_panel.visible = false

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

		# Close memory
		if memory_open:
			memory_panel.visible = false
			memory_open = false
			return

		# Open memory
		memory_text.text = "\"This thread wasn't mine...\""
		memory_panel.visible = true
		memory_open = true

		# Trigger horror reaction only once
		if not memory_collected:
			memory_collected = true

		

			# Short camera shake
			var camera = get_node("../Player/Camera2D")
			camera.shake()
