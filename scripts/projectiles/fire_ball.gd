extends RigidBody2D

@export var MOVE_STRENGTH : float = 200
@export var MAX_BOUNCE : int = 3
@export var MAX_EXISTANCE_TIME : int = 3

var direction : Vector2
var bounce_counter : int = 0
var damage_box : Area2D
var existance_time : float = 0

func _ready():
	apply_force(direction * MOVE_STRENGTH)
	damage_box = $DamageBox
	
func _physics_process(delta):
	
	existance_time += delta
	
	rotation = linear_velocity.angle()
	direction = linear_velocity.normalized()
	
	if bounce_counter == MAX_BOUNCE or existance_time == MAX_EXISTANCE_TIME:
		destroy()

func _on_body_entered(body):
	bounce_counter += 1
	if body.name == "ReflectDetect":
		damage_box.is_hot = true
	

func destroy():  # supposed to be destroy aesthetic when bounced too much, fade away?
	await get_tree().create_timer(0.5).timeout 
	queue_free()

