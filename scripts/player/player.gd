extends CharacterBody2D

@export var MAX_WALK_SPEED : float = 50.0
@export var MAX_RUN_SPEED : float = 75.0
@export var ACCEL_RATE : float = 5
@export var DASH_STRENGTH : float = 200.0
@export var KNOCK_BACK_STRENGTH : float = 100.0
@export var DASH_COST : int = 2
@export var MAX_STAMINA : float = 4

var current_speed : float
var current_stamina : float
var input_direction : Vector2
var fatigued : bool = false
var animation_player : AnimationPlayer
var took_dmg : bool = false
var dead : bool = false

func _ready():
	animation_player = $AnimationPlayer
	current_speed = MAX_WALK_SPEED
	current_stamina = MAX_STAMINA

func _process(delta):
	if !dead:
		input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		current_speed = MAX_WALK_SPEED
		if (Input.is_action_pressed("sprint") && !fatigued):
			current_speed = MAX_RUN_SPEED
		
		if (Input.is_action_just_pressed("dash") && !fatigued):
			dash()
			set_exhausted()
		
		animation_manager()
		stamina_manager(delta)
	
func _physics_process(_delta):
	if !dead:
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
	
func knock_back(dir):
	velocity = ((global_position - dir).normalized() * KNOCK_BACK_STRENGTH)

func animation_manager():
	if velocity.x != 0: $PlayerSpriteSheet.flip_h = (velocity.x < 0) 
	
	if took_dmg:
			animation_player.play("took_dmg")
			await animation_player.animation_finished
			took_dmg = false
	
	if velocity != Vector2.ZERO:
		if current_speed == MAX_WALK_SPEED: animation_player.play("walking")
		elif current_speed == MAX_RUN_SPEED: animation_player.play("running")
	else: 
		animation_player.play("idle")
		
func die():
	if !dead:
		$HandPos.queue_free()
		animation_player.play("die")
		dead = true
