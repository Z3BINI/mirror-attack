extends CharacterBody2D

@export var PLAYER : CharacterBody2D
@export_enum('TYPE1', 'TYPE2', 'TYPE3') var ENEMY_TYPE : String
@export var vanish_effect : GPUParticles2D
@export var KNOCK_BACK_STRENGTH : float = 175

var player_in_range : bool = false
var sprite : Sprite2D
var took_dmg : bool = false
var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $EnemySpriteSheet
	animation_player = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	animation_manager()

func _physics_process(_delta):
	move_and_slide()

func _on_player_detector_body_entered(_body):
	player_in_range = true

func _on_player_detector_body_exited(_body):
	player_in_range = false
	
func knock_back(dir):
	velocity = Vector2.ZERO
	velocity = ((-dir).normalized()) * KNOCK_BACK_STRENGTH  # his direction minus my direction!
	
func animation_manager():
	sprite.flip_h = (velocity.x < 0) 
	
	if took_dmg:
			animation_player.play("took_dmg")
			await animation_player.animation_finished
			took_dmg = false
	
	if velocity != Vector2.ZERO:
		animation_player.play("moving")
	else: 
		animation_player.play("idle")
