extends Area2D

@onready var hand_slam: AudioStreamPlayer = $HandSlamSound

var triggered := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player" and not triggered:
		triggered = true
		
		hand_slam.play()

		var camera = body.get_node("Camera2D")
		camera.shake()
