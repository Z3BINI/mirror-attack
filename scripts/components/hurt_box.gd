extends Area2D

var MAX_HP : float

@onready var take_dmg_ghost_sfx = preload("res://assets/sound/sfx/enemies/ghost_take_dmg.ogg")
@onready var take_dmg_wizrd_sfx = preload("res://assets/sound/sfx/enemies/sorcerer_hit.wav")
@onready var take_dmg_goo_sfx = preload("res://assets/sound/sfx/enemies/goo_hit.mp3")
@onready var take_dmg_boss_sfx = [preload("res://assets/sound/sfx/boss/boss_take_dmg1.wav"),
								preload("res://assets/sound/sfx/boss/boss_take_dmg2.wav")]
								
func _process(delta):
	if get_parent().is_in_group("player"):
		if MAX_HP != PlayerStats.hp: MAX_HP = PlayerStats.hp

func _on_area_entered(area):
	if (get_parent().is_in_group("enemy") and (!area.is_hot or get_parent().vanish_immunity)): return
	if (get_parent().name == "Player" and area.is_hot): return
	take_dmg(area.DMG_AMOUNT, area.global_position)
	area.get_parent().queue_free()
	
func take_dmg(amount, dir):
	get_parent().took_dmg = true
	get_parent().knock_back(dir)
	MAX_HP -= amount
	if get_parent().name == "Player": PlayerStats.hp = MAX_HP
	else:
		match (get_parent().ENEMY_TYPE):
			"TYPE1":
				AudioManager.play_sfx(take_dmg_ghost_sfx, self, 0)
			"TYPE2":
				AudioManager.play_sfx(take_dmg_wizrd_sfx, self, -5)
			"TYPE3":
				AudioManager.play_sfx(take_dmg_goo_sfx, self, 0)
			"BOSS":
				AudioManager.play_sfx(take_dmg_boss_sfx.pick_random(), self, -5)
	if MAX_HP <= 0:
		die()
	
func die():
	if get_parent().name == "Player": get_parent().die()
	else: get_parent().dead = true

