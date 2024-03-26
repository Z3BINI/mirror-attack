extends Node2D

@export var NEXT_LEVEL : PackedScene

var room_cleared : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Enemies.get_children().size() <= 0):
		room_cleared = true
	
