extends Area2D

@export var teddy_world_path: String = "res://TeddyWorld/TeddyWorld.tscn"

var player_near := false
var player: CharacterBody2D

@onready var interaction_label: Label = $InteractionLabel


func _ready():
	interaction_label.visible = false


func _on_body_entered(body):
	if body is CharacterBody2D:
		player_near = true
		player = body
		interaction_label.visible = true


func _on_body_exited(body):
	if body == player:
		player_near = false
		player = null
		interaction_label.visible = false


func _process(_delta):
	if player_near and Input.is_key_pressed(KEY_E):
		get_tree().change_scene_to_file(teddy_world_path)
