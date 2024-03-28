extends Node2D

@export var NEXT_LEVEL : PackedScene
@export var FADE_TIMER : float = 3

var room_cleared : bool = false
var player_on_door : bool = false

var fade_main : bool = false
var boss_started : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if name == "ThankYouLevel":
		AudioManager.main_theme.stop()
		AudioManager.boss_theme.stop()
		AudioManager.win_theme.volume_db = -10
		AudioManager.win_theme.play()
		
	
	PlayerStats.player_load_hp = PlayerStats.hp
	
	if AudioManager.boss_theme.is_playing(): 
		AudioManager.boss_theme.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fade_main == true: fade_main_theme(delta)
	if ($Enemies.get_children().size() <= 0):
		room_cleared = true
	if Input.is_action_pressed("interact") and player_on_door: 
		load_next_level()

func fade_main_theme(delta):
	FADE_TIMER -= delta 
	AudioManager.main_theme.volume_db -= FADE_TIMER * 0.05
	if FADE_TIMER <= 0: 
		AudioManager.main_theme.stop()
		AudioManager.boss_theme.play()
		fade_main = false

func load_next_level():
	get_tree().change_scene_to_packed(NEXT_LEVEL)


func _on_boss_music_trigger_body_entered(body):
	if !boss_started:
		fade_main = true
		boss_started = true
