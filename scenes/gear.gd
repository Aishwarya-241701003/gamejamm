extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		GameManager.gears += 1
		print("Gears:", GameManager.gears)
		queue_free()
