extends RigidBody2D

@export var MOVE_STRENGTH : float = 200
@export var MAX_BOUNCE : int = 3

var direction : Vector2
var bounce_counter : int = 0

func _ready():
	apply_force(direction * MOVE_STRENGTH)
	
func _physics_process(_delta):
	rotation = linear_velocity.angle()
	direction = linear_velocity.normalized()
	
	if bounce_counter == MAX_BOUNCE:
		destroy()

func _on_body_entered(body):
	bounce_counter += 1

func destroy():  # supposed to be destroy aesthetic when bounced too much, fade away?
	await get_tree().create_timer(0.5).timeout 
	queue_free()

func _on_damage_box_area_entered(area):
	queue_free() # needs a destroy immediate when hit player
