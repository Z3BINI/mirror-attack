extends CanvasLayer

@onready var hp_animations : AnimationPlayer = $HpAnimations
@onready var nrg_animations : AnimationPlayer = $NrgAnimations

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LifeBar.value = PlayerStats.hp * 100 / PlayerStats.MAX_HP
	$NrgBar.value = PlayerStats.stamina * 100 / PlayerStats.MAX_STAMINA
	
	if !PlayerStats.dead && Input.is_action_just_pressed("show_menu"):
		toggle_pause()
	
	if PlayerStats.dead:
		$Menu.show_dead()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	$Menu.toggle_pause()

func took_dmg():
	hp_animations.play("took_dmg")
	
func stamina_exhausted(status):
	if !status: nrg_animations.stop()
	else: nrg_animations.play("stamina_reset")
	
