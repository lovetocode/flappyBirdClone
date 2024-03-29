extends Node2D

const SPEED = 215

signal score

onready var point = $Point

func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -200:
		queue_free()



func _on_Wall_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()


func _on_scoreArea_body_exited(body):
	if body is Player:
		point.play()
		emit_signal("score")
