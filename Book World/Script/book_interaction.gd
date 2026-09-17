extends StaticBody2D

var used := false
var interaction_distance := 120.0
var player = null


func _ready():
	player = get_tree().current_scene.find_child("Player", true, false)


func _process(_delta):
	if used:
		return

	if player == null:
		return

	var distance = global_position.distance_to(player.global_position)

	if distance <= interaction_distance:
		if Input.is_key_pressed(KEY_E):
			used = true

			get_tree().change_scene_to_file(
				"res://Book World/Scene/Forest.tscn"
			)
