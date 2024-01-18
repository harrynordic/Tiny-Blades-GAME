extends Area2D

@export var damage: int = 1


func _on_body_entered(body):
	body.update_health(damage)


func _on_lifetime_timeout():
	queue_free()
