extends StaticBody2D

func _ready():
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	
func close_door():
	$Sprite2D.visible = true
	
	$CollisionShape2D.disabled = false
