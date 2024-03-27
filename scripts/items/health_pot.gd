extends Area2D

@export var HEAL_VALUE : float = 1

func _on_area_entered(area):
	PlayerStats.hp += HEAL_VALUE
	area.get_parent().play_heal()
	queue_free()
