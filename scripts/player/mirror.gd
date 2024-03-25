extends Sprite2D

var smooth_mouse_pos : Vector2

@onready var player_hand : Node2D = get_parent()

func _physics_process(_delta):
	smooth_mouse_pos = lerp(smooth_mouse_pos, get_global_mouse_position(), 0.3)
	player_hand.look_at(smooth_mouse_pos)
