extends CharacterBody2D

@export var speed: float = 250.0
@export var jump_force: float = -300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get horizontal input
	var direction := Input.get_axis("move_left", "move_right")

	# Move left/right
	velocity.x = direction * speed

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Flip sprite
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false

	# Move the player
	move_and_slide()

	# Play animations
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")
