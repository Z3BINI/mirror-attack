extends State
class_name Roam

@export var ROAM_SPEED : float = 10
@export var MIN_ROAM_TIME : float = 1
@export var MAX_ROAM_TIME : float = 5

var move_direction : Vector2
var roam_time : float

func randomize_roam_time():
	roam_time = randf_range(MIN_ROAM_TIME, MAX_ROAM_TIME)

func randomize_roam_dir():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func enter_state():
	randomize_roam_time()
	randomize_roam_dir()

func update(delta):
	if self_body.player_in_range and !self_body.PLAYER.dead:
		state_changed.emit(self, 'hostile')
	
	if roam_time > 0:
		roam_time -= delta
	else:
		state_changed.emit(self, 'idle')

func physics_update(_delta):
	if self_body:
		self_body.velocity = move_direction * ROAM_SPEED
		
		if self_body.is_on_wall():  # Move away from walls
			move_direction = self_body.get_wall_normal()

