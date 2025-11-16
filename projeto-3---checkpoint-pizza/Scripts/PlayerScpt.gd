extends CharacterBody2D

var jump_force := -620
var speed := 150
var gravity := 1200
var pos := Vector2.ZERO
var life := 0

signal player_death


func _physics_process(delta: float) -> void:
	jumping()
	
	pos.x = speed
	pos.y += gravity * delta
	set_velocity(pos)
	move_and_slide()



func jumping() -> void:
	if Input.is_action_just_pressed("ui_up"):
		$Anim.play("Fly")
		$JumpFX.play()
		pos.y = jump_force / 2
	if Input.is_action_just_released("ui_up"):
		$Anim.play("Fall")


func _on_detector_body_entered(body: Node2D) -> void:
	if body:
		$DeathFX.play()
		emit_signal("player_death")
		hide()
		gravity = 0
		jump_force = 0
		speed = 0
