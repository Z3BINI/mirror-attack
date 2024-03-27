extends Node

@onready var main_theme = $MainTheme
@onready var sfx_player = $SFXplayer

# Called when the node enters the scene tree for the first time.
func _ready():
	main_theme.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playsfx(node, sfx):
	pass
