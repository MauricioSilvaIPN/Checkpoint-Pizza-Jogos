extends CharacterBody2D

var speed := -100
var pos := Vector2.ZERO
var direction = -1
var gravity := 1200

@onready var raycast = $RayCast2D


func _physics_process(delta: float) -> void:
	pos.y += gravity * delta
	
	pos.x = speed * direction
	set_velocity(pos)
	move_and_slide()
	pos = velocity

	if raycast.is_colliding():
		direction *= -1
		raycast.scale.x *= -1
	
	if Global.score > 1500:
		speed = -150
	
	if Global.score > 2000:
		speed = -200
	
	if Global.score > 5000:
		speed = -250
