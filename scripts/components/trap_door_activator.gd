extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _on_body_entered(body):
	$TrapDoor.close_door()
	$CollisionShape2D.disabled = true
