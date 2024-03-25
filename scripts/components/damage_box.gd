extends Area2D

@export var DMG_AMOUNT : float = 2

func enable_collision():
	$CollisionShape2D.disabled = false
