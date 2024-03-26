extends Area2D

var MAX_HP : float = 10

func _on_area_entered(area):
	if (get_parent().is_in_group("enemy") and !area.is_hot): return
	take_dmg(area.DMG_AMOUNT, area.global_position)
	area.get_parent().queue_free()
	
func take_dmg(amount, dir):
	get_parent().took_dmg = true
	get_parent().knock_back(dir)
	MAX_HP -= amount
	if MAX_HP <= 0:
		die()
	
func die():
	if get_parent().name == "Player": get_parent().die()
	else: get_parent().dead = true


