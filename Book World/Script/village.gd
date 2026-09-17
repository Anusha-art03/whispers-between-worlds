extends Node2D

const ENCHANTED_FOREST_SCENE = preload("res://Book World/Scene/Enchanted forest.tscn")

@onready var player = $Player
@onready var page_point = $PagePoint
@onready var dialogue_box: PanelContainer = $Player/DialogueBox
@onready var dialogue_label: Label = $Player/DialogueBox/DialogueLabel
@onready var dim_screen: ColorRect = $DialogueUI/DimScreen
@onready var story_page: ColorRect = $StoryPage

var page_found := false
var page_distance := 70.0


func _ready():
	dialogue_box.hide()
	dim_screen.hide()


func _process(_delta):
	if page_found:
		return

	if player.position.distance_to(page_point.position) < page_distance:
		if Input.is_key_pressed(KEY_E):
			show_page_story()


func show_page_story():
	page_found = true

	# Pick up the page
	story_page.hide()

	# Start dialogue
	dim_screen.show()
	dialogue_box.show()

	dialogue_label.text = "Once upon a time, there lived a princess\nwho was loved by an entire kingdom..."

	await get_tree().create_timer(3.5).timeout

	dialogue_label.text = "She was here."

	await get_tree().create_timer(2.5).timeout

	# End dialogue
	dialogue_box.hide()
	dim_screen.hide()

	await get_tree().create_timer(1.0).timeout

	# Move to Act 3
	get_tree().change_scene_to_packed(ENCHANTED_FOREST_SCENE)
