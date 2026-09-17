extends Area2D

@onready var sound: AudioStreamPlayer = $BubbleSound


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.name == "Player":
		if not sound.playing:
			sound.play()

		# Short camera shake when stepping on the bubble wrap
		var camera = body.get_node("Camera2D")
		camera.shake()


func _on_body_exited(body):
	if body.name == "Player":
		sound.stop()
