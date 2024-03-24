extends CharacterBody2D

@export var MAX_WALK_SPEED : float = 50.0
@export var MAX_RUN_SPEED : float = 75.0
@export var ACCEL_RATE : float = 5
@export var DASH_STRENGTH : float = 200.0

var current_speed : float
var input_direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	current_speed = MAX_WALK_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	current_speed = MAX_RUN_SPEED if (Input.is_action_pressed("sprint")) else MAX_WALK_SPEED
	
	print(velocity)
	
func _physics_process(delta):
	velocity = velocity.move_toward(input_direction * current_speed, ACCEL_RATE)
	move_and_slide()
	
