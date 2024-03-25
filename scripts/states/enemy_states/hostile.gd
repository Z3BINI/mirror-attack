extends State
class_name  Hostile

@export var CHASE_SPEED : float = 125

func enter_state():
	pass

func update(_delta):
	if !self_body.player_in_range:
		state_changed.emit(self, 'roam')

func physics_update(_delta):
	var player_dir : Vector2 = (self_body.PLAYER.global_position - self_body.global_position).normalized()
	
	self_body.velocity = self_body.velocity.move_toward(player_dir * CHASE_SPEED, 2)
	
	

