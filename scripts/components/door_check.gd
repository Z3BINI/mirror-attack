extends Area2D

func _on_body_entered(_body):
	if get_parent().room_cleared:
		$PassLabel.visible = true
	else:
		$BlockLabel.visible = true
	
func _on_body_exited(_body):
		$PassLabel.visible = false
		$BlockLabel.visible = false
	
