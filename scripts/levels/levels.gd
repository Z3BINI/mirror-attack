extends Node2D

@export var NEXT_LEVEL : PackedScene

var room_cleared : bool = false
var player_on_door : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.player_load_hp = PlayerStats.hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Enemies.get_children().size() <= 0):
		room_cleared = true
	if Input.is_action_pressed("interact") and player_on_door: 
		load_next_level()
	
func load_next_level():
	get_tree().change_scene_to_packed(NEXT_LEVEL)
