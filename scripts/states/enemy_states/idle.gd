extends State
class_name  Idle

@export var MIN_IDLE_TIME : float = 5
@export var MAX_IDLE_TIME : float = 10

var idle_time : float

func randomize_idle_time():
	idle_time = randf_range(MIN_IDLE_TIME, MAX_IDLE_TIME)

func enter_state():
	randomize_idle_time()

func update(delta):
	if self_body.player_in_range:
		state_changed.emit(self, 'hostile')
	
	if idle_time > 0:
		idle_time -= delta
	else:
		state_changed.emit(self, 'roam')

func physics_update(_delta):
	if self_body:
		self_body.velocity = Vector2.ZERO

