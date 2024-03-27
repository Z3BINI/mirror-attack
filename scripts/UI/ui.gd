extends CanvasLayer

@onready var hp_animations : AnimationPlayer = $HpAnimations
@onready var nrg_animations : AnimationPlayer = $NrgAnimations

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LifeBar.value = PlayerStats.hp * 100 / PlayerStats.MAX_HP
	$NrgBar.value = PlayerStats.stamina * 100 / PlayerStats.MAX_STAMINA


func took_dmg():
	hp_animations.play("took_dmg")
	
func stamina_exhausted(status):
	if !status: nrg_animations.stop()
	else: nrg_animations.play("stamina_reset")
	
