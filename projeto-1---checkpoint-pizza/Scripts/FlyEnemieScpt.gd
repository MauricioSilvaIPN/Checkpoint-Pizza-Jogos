extends CharacterBody2D

var direction := -1
var speed := -120
var pos := Vector2.ZERO

@onready var raycast = $RayCast2D


func _physics_process(delta: float) -> void:
	movement()
	
	if raycast.is_colliding():
		raycast.scale.x *= -1
		direction *= -1



func movement() -> void:
	pos.x = speed * direction
	
	set_velocity(pos)
	move_and_slide()
	pos = velocity


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	set_physics_process(true)


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	set_physics_process(false)
