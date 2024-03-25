extends CharacterBody2D

@export var PLAYER : CharacterBody2D
@export_enum('TYPE1', 'TYPE2', 'TYPE3') var ENEMY_TYPE : String
@export var vanish_effect : GPUParticles2D
@export var KNOCK_BACK_STRENGTH : float = 100.0

var player_in_range : bool = false
var sprite : Sprite2D
var took_dmg : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $EnemySpriteSheet

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	move_and_slide()

func _on_player_detector_body_entered(_body):
	player_in_range = true

func _on_player_detector_body_exited(_body):
	player_in_range = false
	
func knock_back(dir):
	velocity = ((global_position - dir).normalized() * KNOCK_BACK_STRENGTH)
