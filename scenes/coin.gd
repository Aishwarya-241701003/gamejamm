extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		GameManager.coins += 1
		print("Coins:", GameManager.coins)
		queue_free()
