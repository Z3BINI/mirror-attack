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

func physics_update(delta):
	var player_dir : Vector2 = (self_body.PLAYER.global_position - self_body.global_position).normalized()
	var distance_to_player : float = (self_body.PLAYER.global_position - self_body.global_position).length()
	
	self_body.velocity = self_body.velocity.move_toward(player_dir * CHASE_SPEED, 2)
	if distance_to_player <= 40:
		self_body.velocity = Vector2.ZERO
	
	if self_body.ENEMY_TYPE != "TYPE3" and self_body.ENEMY_TYPE != "BOSS":
		if has_shot == false:
			if self_body.ENEMY_TYPE == "TYPE2": mega_shoot()
			shoot(player_dir)
			has_shot = true
	else:
		if self_body.ENEMY_TYPE != "BOSS":
			if has_shot == false:
				vanish_attack(player_dir, distance_to_player)
				has_shot = true
			
	if self_body.ENEMY_TYPE == "BOSS":
		boss_mechanics(delta, player_dir, distance_to_player)
		
	
func boss_mechanics(delta, player_dir, distance):
	if has_shot == false:
		var decision = randi_range(0, 2)
		match(decision):
			0:
				shoot(player_dir)
			1:
				mega_shoot()
			2:
				vanish_attack(player_dir, distance)
				
		has_shot = true
		
	
func shoot(player_dir):
	var projectile : RigidBody2D = preload("res://scenes/projectiles/fire_ball.tscn").instantiate()
	projectile.direction = player_dir
	projectile.position = self_body.global_position
	add_child(projectile)

func mega_shoot():
	shoot(Vector2.UP)
	shoot(Vector2.DOWN)	
	shoot(Vector2.LEFT)
	shoot(Vector2.RIGHT)

func vanish_attack(dir, distance):
	has_shot = true
	self_body.vanish_effect.emitting = true
	self_body.sprite.visible = false
	await self_body.vanish_effect.finished
	
	self_body.global_position += dir * (distance + 20)
	self_body.sprite.visible = true
	shoot(-dir)
	
	
func reset_shot(delta):
	cooldown += delta
	
	if cooldown >= SHOOT_COOLDOWN:
		has_shot = false
		cooldown = 0

