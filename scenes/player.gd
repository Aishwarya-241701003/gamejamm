extends CharacterBody2D

@export var speed: float = 250.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var jumping := false


func _ready() -> void:
	sprite.animation_finished.connect(_on_animation_finished)


func _physics_process(_delta: float) -> void:
	var direction := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)

	# Jump
	if Input.is_action_just_pressed("jump") and not jumping:
		jumping = true
		sprite.play("jump")

	# Movement
	if not jumping:
		if direction.length() > 0.0:
			direction = direction.normalized()
			velocity = direction * speed
			sprite.play("run")

			# Face left/right
			if direction.x < 0:
				sprite.flip_h = true
			elif direction.x > 0:
				sprite.flip_h = false

		else:
			velocity = Vector2.ZERO
			sprite.play("idle")

	move_and_slide()


func _on_animation_finished() -> void:
	if sprite.animation == "jump":
		jumping = false
