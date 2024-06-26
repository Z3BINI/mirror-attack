extends CharacterBody2D

@export var MAX_WALK_SPEED : float = 50.0
@export var MAX_RUN_SPEED : float = 75.0
@export var ACCEL_RATE : float = 5
@export var DASH_STRENGTH : float = 200.0
@export var KNOCK_BACK_STRENGTH : float = 100.0
@export var DASH_COST : int = 2
@export var MAX_STAMINA : float = 4
@export var HP : float = 10
@export var UI : CanvasLayer

@onready var dash_sfx = preload("res://assets/sound/sfx/player/dash.mp3")
@onready var heal_sfx = preload("res://assets/sound/sfx/player/heal.wav")
@onready var hit_sfx = [ preload("res://assets/sound/sfx/player/player_hit1.mp3"),
						preload("res://assets/sound/sfx/player/player_hit2.mp3"),
						preload("res://assets/sound/sfx/player/player_hit3.mp3")
						]

var current_speed : float
var current_stamina : float
var input_direction : Vector2
var fatigued : bool = false
var animation_player : AnimationPlayer
var took_dmg : bool = false
var dead : bool = false


func _ready():
	UI = get_tree().get_first_node_in_group("ui")
	animation_player = $AnimationPlayer
	current_speed = MAX_WALK_SPEED
	current_stamina = MAX_STAMINA
	PlayerStats.MAX_STAMINA = MAX_STAMINA
	
	if !PlayerStats.hp:
		PlayerStats.MAX_HP = HP
		PlayerStats.hp = HP
		$HurtBox.MAX_HP = HP
	else:
		$HurtBox.MAX_HP = PlayerStats.hp
	

func _process(delta):
	if !dead:
		input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		current_speed = MAX_WALK_SPEED
		if (Input.is_action_pressed("sprint") && !fatigued):
			current_speed = MAX_RUN_SPEED
		
		if (Input.is_action_just_pressed("dash") && !fatigued):
			dash()
			current_stamina -= DASH_COST
		
		if PlayerStats.hp > HP:
			PlayerStats.hp = HP
			
		animation_manager()
		stamina_manager(delta)
	
func _physics_process(_delta):
	if !dead:
		velocity = velocity.move_toward(input_direction * current_speed, ACCEL_RATE)
		move_and_slide()
	
func dash():
	AudioManager.play_sfx(dash_sfx, self, 0)
	velocity = (get_global_mouse_position() - global_position).normalized() * DASH_STRENGTH

func stamina_manager(delta):
	PlayerStats.stamina = current_stamina
	if current_stamina <= 0: set_exhausted()
	if current_speed == MAX_RUN_SPEED and velocity != Vector2.ZERO:
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
	var random_hit_pick = hit_sfx.pick_random()
	AudioManager.play_sfx(random_hit_pick, self, 0)
	velocity = ((global_position - dir).normalized() * KNOCK_BACK_STRENGTH)

func play_heal():
	AudioManager.play_sfx(heal_sfx, self, 0)
	$HealPlay.play("heal")

func animation_manager():
	if dead: return
	if velocity.x != 0: $PlayerSpriteSheet.flip_h = (velocity.x < 0) 
	
	UI.stamina_exhausted(fatigued)
		
	if took_dmg:
			animation_player.play("took_dmg")
			UI.took_dmg()
			await animation_player.animation_finished
			took_dmg = false
	
	if velocity != Vector2.ZERO:
		if current_speed == MAX_WALK_SPEED: animation_player.play("walking")
		elif current_speed == MAX_RUN_SPEED: animation_player.play("running")
	else: 
		animation_player.play("idle")
		
func die():
	if !dead:
		dead = true
		PlayerStats.dead = true
		UI.took_dmg()
		UI.stamina_exhausted(false)
		animation_player.play("took_dmg")
		await animation_player.animation_finished
		$HandPos.queue_free()
		animation_player.play("die")
	
