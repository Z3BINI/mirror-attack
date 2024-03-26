extends Area2D

func _on_body_entered(_body):
	if get_parent().room_cleared:
		$PassLabel.visible = true
		get_parent().player_on_door = true
	else:
		$BlockLabel.visible = true
	
func _on_body_exited(_body):
	get_parent().player_on_door = false
	$PassLabel.visible = false
	$BlockLabel.visible = false
	
