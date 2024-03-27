extends Node

@onready var main_theme = $MainTheme

# Called when the node enters the scene tree for the first time.
func _ready():
	main_theme.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
