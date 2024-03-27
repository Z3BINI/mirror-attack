extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LifeBar.value = PlayerStats.hp * 100 / PlayerStats.MAX_HP
	$NrgBar.value = PlayerStats.stamina * 100 / PlayerStats.MAX_STAMINA
