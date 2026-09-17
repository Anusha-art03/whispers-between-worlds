extends Camera2D

var shake_strength := 0.0
var shake_time := 0.0

@export var shake_duration := 0.18
@export var shake_amount := 5.0


func _process(delta):
	if shake_time > 0.0:
		shake_time -= delta

		offset = Vector2(
			randf_range(-shake_amount, shake_amount),
			randf_range(-shake_amount, shake_amount)
		)

	else:
		offset = Vector2.ZERO


func shake():
	shake_time = shake_duration
