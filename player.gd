extends CharacterBody2D

@export var speed := 200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta):
	var direction := Vector2.ZERO

	# Movement
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		direction.y -= 1

	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		direction.y += 1

	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1

	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1

	direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()

	# Walking animation
	if direction == Vector2.ZERO:
		animated_sprite.stop()
	else:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animated_sprite.play("idle_right")
			else:
				animated_sprite.play("idle_left")
		else:
			if direction.y > 0:
				animated_sprite.play("idle_down")
			else:
				animated_sprite.play("idle_up")
