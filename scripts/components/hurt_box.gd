extends Area2D

@export var MAX_HP : float = 10

func _process(delta):
	if MAX_HP <= 0:
		die()
	
func _on_area_entered(area):
	if (get_parent().is_in_group("enemy") and !area.is_hot): return
	take_dmg(area.DMG_AMOUNT)
	area.get_parent().queue_free()
	
func take_dmg(amount):
	MAX_HP -= amount
	print("dmged")
	
func die():
	print("dead")
	


