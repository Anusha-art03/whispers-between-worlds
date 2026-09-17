extends Node2D

@onready var player = $Player
@onready var story_page: Label = $StoryPage
@onready var mirror_trigger: ColorRect = $MirrorTrigger

@onready var dialogue_box: PanelContainer = $Player/DialogueBox
@onready var dialogue_label: Label = $Player/DialogueBox/DialogueLabel
@onready var dim_screen: ColorRect = $DialogueUI/DimScreen

var page_found := false
var mirror_used := false

var interaction_distance := 70.0


func _ready():
	dialogue_box.hide()
	dim_screen.hide()


func _process(_delta):
	if not page_found:
		if player.position.distance_to(story_page.position) < interaction_distance:
			if Input.is_key_pressed(KEY_E):
				read_page()

	elif not mirror_used:
		if player.position.distance_to(mirror_trigger.position) < interaction_distance:
			if Input.is_key_pressed(KEY_E):
				activate_mirror()


func read_page():
	page_found = true

	story_page.hide()

	dim_screen.show()
	dialogue_box.show()

	dialogue_label.text = "The princess entered the Forbidden Forest\nto save her kingdom."

	await get_tree().create_timer(3.5).timeout

	dialogue_label.text = "She never returned."

	await get_tree().create_timer(2.5).timeout

	dialogue_box.hide()
	dim_screen.hide()


func activate_mirror():
	mirror_used = true

	dim_screen.show()
	dialogue_box.show()

	dialogue_label.text = "The mirror shows a vision..."

	await get_tree().create_timer(2.0).timeout

	dialogue_label.text = "Please... don't let them finish the story."

	await get_tree().create_timer(3.0).timeout

	dialogue_box.hide()
	dim_screen.hide()

	await get_tree().create_timer(1.0).timeout

	get_tree().change_scene_to_file(
		"res://Book World/Scene/Castle.tscn"
	)
