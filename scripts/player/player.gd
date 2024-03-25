extends CharacterBody2D

@export var MAX_WALK_SPEED : float = 50.0
@export var MAX_RUN_SPEED : float = 75.0
@export var ACCEL_RATE : float = 5
@export var DASH_STRENGTH : float = 200.0
@export var DASH_COST : int = 2
@export var MAX_STAMINA : float = 4

var current_speed : float
var current_stamina : float
var input_direction : Vector2
var fatigued : bool = false

func _ready():
	current_speed = MAX_WALK_SPEED
	current_stamina = MAX_STAMINA

func _process(delta):
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	current_speed = MAX_WALK_SPEED
	if (Input.is_action_pressed("sprint") && !fatigued):
		current_speed = MAX_RUN_SPEED
	
	if (Input.is_action_just_pressed("dash") && !fatigued):
		dash()
		set_exhausted()
	
	stamina_manager(delta)
	
func _physics_process(_delta):
	velocity = velocity.move_toward(input_direction * current_speed, ACCEL_RATE)
	move_and_slide()
	
func dash():
	velocity = input_direction * DASH_STRENGTH

func stamina_manager(delta):
	if current_speed == MAX_RUN_SPEED:
		current_stamina -= delta
		if current_stamina <= 0: set_exhausted()
	else:
		if current_stamina < MAX_STAMINA:
			current_stamina += delta
		else:
			set_replenished()

func set_exhausted():
	current_stamina = 0
	fatigued = true
	
func set_replenished():
	current_stamina = MAX_STAMINA
	fatigued = false
