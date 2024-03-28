extends Control

@onready var pause_menu = $Pause
@onready var dead_menu = $Dead

# Called when the node enters the scene tree for the first time.
func _ready():
	$Pause/MusicToggle.button_pressed = AudioManager.main_theme.playing


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggle_pause():
	pause_menu.visible = !pause_menu.visible

func show_dead():
	dead_menu.visible = true

func _on_return_pressed():
	pause_menu.visible = false
	get_tree().paused = false


func _on_music_toggle_toggled(toggled_on):
	AudioManager.main_theme.volume_db = -17
	AudioManager.music = toggled_on
	if !toggled_on: AudioManager.main_theme.stop()
	else: AudioManager.main_theme.play()


func _on_retry_pressed():
	if $Pause/MusicToggle.button_pressed == true:
		_on_music_toggle_toggled(true)
		AudioManager.main_theme.volume_db = -17
	PlayerStats.hp = PlayerStats.player_load_hp
	PlayerStats.dead = false
	get_tree().reload_current_scene()
	
func restart_game():
	PlayerStats.hp = PlayerStats.MAX_HP
	PlayerStats.dead = false
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_quit_pressed():
	get_tree().quit()
