extends Area2D

@export var act2_spawn: Marker2D



func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		body.global_position = act2_spawn.global_position
