extends CharacterBody2D

@export var PLAYER : CharacterBody2D
@export_enum('TYPE1', 'TYPE2', 'TYPE3', 'BOSS') var ENEMY_TYPE : String
@export var vanish_effect : GPUParticles2D
@export var KNOCK_BACK_STRENGTH : float = 175
@export var MAX_HP : float = 2
@export var SHOOT_CD : float = 2
@export var TRAP_DOOR : StaticBody2D

var player_in_range : bool = false
var sprite : Sprite2D
var took_dmg : bool = false
var animation_player : AnimationPlayer
var dead : bool = false
var vanish_immunity : bool = false
var knocked : bool = false
var health_bar : TextureProgressBar 

# Called when the node enters the scene tree for the first time.
func _ready():
	$StateMachine/Hostile.SHOOT_COOLDOWN = SHOOT_CD
	sprite = $EnemySpriteSheet
	animation_player = $AnimationPlayer
	$HurtBox.MAX_HP = MAX_HP
	health_bar = $EnemyHealth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	animation_manager()
	health_bar.value = $HurtBox.MAX_HP * 100 / MAX_HP

func _physics_process(_delta):
	move_and_slide()

func _on_player_detector_body_entered(_body):
	player_in_range = true

func _on_player_detector_body_exited(_body):
	player_in_range = false
	
func knock_back(dir):
	knocked = true
	velocity = Vector2.ZERO
	velocity = ((global_position - dir).normalized() * KNOCK_BACK_STRENGTH)
	await get_tree().create_timer(1).timeout
	knocked = false
	
func animation_manager():
	if !dead:
		sprite.flip_h = (velocity.x <= 0) 
		
	if took_dmg:
		animation_player.play("took_dmg")
		await animation_player.animation_finished
		took_dmg = false
		
			
	if dead:
		$HurtBox.monitoring = false
		velocity = Vector2.ZERO
		animation_player.play("die")
		await animation_player.animation_finished
		if TRAP_DOOR: TRAP_DOOR.queue_free()
		queue_free()
	
	if velocity != Vector2.ZERO:
		animation_player.play("moving")
	else: 
		animation_player.play("idle")
