extends State
class_name  Hostile

@export var CHASE_SPEED : float = 75
@export var SHOOT_COOLDOWN : float = 4

var has_shot : bool = false
var cooldown : float = 0

func enter_state():
	pass

func update(delta):
	if !self_body.player_in_range:
		state_changed.emit(self, 'roam')
		
	if has_shot:
		reset_shot(delta)

func physics_update(_delta):
	var player_dir : Vector2 = (self_body.PLAYER.global_position - self_body.global_position).normalized()
	
	self_body.velocity = self_body.velocity.move_toward(player_dir * CHASE_SPEED, 2)
	
	if has_shot == false:
		shoot(player_dir)
		has_shot = true
	
func shoot(player_dir):
	var projectile : RigidBody2D = preload("res://scenes/projectiles/fire_ball.tscn").instantiate()
	projectile.direction = player_dir
	projectile.position = self_body.global_position
	add_child(projectile)
	
func reset_shot(delta):
	cooldown += delta
	
	if cooldown >= SHOOT_COOLDOWN:
		has_shot = false
		cooldown = 0

