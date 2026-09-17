extends Node2D

@onready var player = $Player
@onready var princess_point = $Princess/PrincessPoint
@onready var final_page: ColorRect = $FinalPage

@onready var dialogue_box: PanelContainer = $Player/DialogueBox
@onready var dialogue_label: Label = $Player/DialogueBox/DialogueLabel
@onready var dim_screen: ColorRect = $DialogueUI/DimScreen

@onready var choice_ui: CanvasLayer = $ChoiceUI
@onready var restore_button: Button = $ChoiceUI/RestoreButton
@onready var destroy_button: Button = $ChoiceUI/DestroyButton

var princess_met := false
var interaction_distance := 80.0


func _ready():
	# Hide story UI at the beginning.
	dialogue_box.hide()
	dim_screen.hide()
	final_page.hide()
	choice_ui.hide()


func _process(_delta):
	if princess_met:
		return

	if player.position.distance_to(princess_point.position) < interaction_distance:
		if Input.is_key_pressed(KEY_E):
			meet_princess()


func meet_princess():
	princess_met = true

	# Start cinematic dialogue.
	dim_screen.show()
	dialogue_box.show()

	dialogue_label.text = "Every story needs an ending."

	await get_tree().create_timer(2.5).timeout

	dialogue_label.text = "But someone changed mine."

	await get_tree().create_timer(2.5).timeout

	dialogue_label.text = "The kingdom's story was being corrupted."

	await get_tree().create_timer(2.5).timeout

	dialogue_label.text = "The villagers began disappearing.\nThen the forest."

	await get_tree().create_timer(3.0).timeout

	dialogue_label.text = "Soon, I would disappear too."

	await get_tree().create_timer(2.5).timeout

	dialogue_label.text = "I trapped myself inside the story\nto protect what remained."

	await get_tree().create_timer(3.0).timeout

	dialogue_label.text = "Take the final page."

	await get_tree().create_timer(2.0).timeout

	# Show the final missing page.
	final_page.show()

	dialogue_label.text = "Now you must decide what happens to my story."

	await get_tree().create_timer(2.5).timeout

	# End dialogue.
	dialogue_box.hide()
	dim_screen.hide()

	# Show the two choices.
	show_choice_buttons()


func show_choice_buttons():
	choice_ui.show()

	var screen_size = get_viewport().get_visible_rect().size

	restore_button.size = Vector2(200, 45)
	destroy_button.size = Vector2(200, 45)

	restore_button.position = Vector2(
		screen_size.x / 2.0 - 220,
		screen_size.y - 80
	)

	destroy_button.position = Vector2(
		screen_size.x / 2.0 + 20,
		screen_size.y - 80
	)

	restore_button.show()
	destroy_button.show()

func _on_restore_button_pressed():
	choice_ui.hide()

	dim_screen.show()
	dialogue_box.show()

	dialogue_label.text = "The story begins to glow."

	await get_tree().create_timer(2.5).timeout

	dialogue_label.text = "Every story deserves a chance\nto be remembered."

	await get_tree().create_timer(3.0).timeout

	dialogue_label.text = "THE STORY REMEMBERED"

	await get_tree().create_timer(3.0).timeout

	get_tree().change_scene_to_file("res://Attic.tscn")


func _on_destroy_button_pressed():
	choice_ui.hide()

	dim_screen.show()
	dialogue_box.show()

	dialogue_label.text = "The page tears apart."

	await get_tree().create_timer(2.5).timeout

	dialogue_label.text = "Perhaps... some stories are meant\nto remain unfinished."

	await get_tree().create_timer(3.0).timeout

	dialogue_label.text = "THE FORGOTTEN TALE"

	await get_tree().create_timer(3.0).timeout

	get_tree().change_scene_to_file("res://Attic.tscn")
