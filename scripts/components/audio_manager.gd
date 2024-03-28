extends Node

@onready var main_theme = $MainTheme
@onready var sfx_player = $SFXplayer
@onready var boss_theme = $BossTheme
@onready var win_theme = $WinTheme

var music : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	main_theme.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_sfx(sound : AudioStream, parent_node : Node, volume : float):
	if sound != null or parent_node != null:
		var stream = AudioStreamPlayer2D.new()
		
		stream.stream = sound
		stream.volume_db = volume
		
		stream.connect('finished', stream.queue_free)
		
		parent_node.add_child(stream)
		stream.play()
