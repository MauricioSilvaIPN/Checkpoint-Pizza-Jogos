class_name Player
extends CharacterBody2D

@export var life := 1
@export var speed := 175
@export var jump_force := -720

@onready var detector = $Detector/Col
@onready var collision_shape = $Col
@onready var coyote_timer = $CoyoteTimer

var gravity := 1200
var pos := Vector2.ZERO
var has_won := false
var can_jump := true


func _physics_process(delta: float) -> void:
	pos.y += gravity * delta

	movement()
	jumping()
	animation()

	if global_position.y > 450:
		hide()
	
	if is_on_floor() and can_jump == false:
		can_jump = true
	elif can_jump and coyote_timer.is_stopped():
		coyote_timer.start()


func movement() -> void:
	pos.x = 0
	var direction_x = int(Input.is_action_pressed("ui_right")) -int(Input.is_action_pressed("ui_left"))

	if direction_x != 0 and life > 0:
		$Sprite2D.scale.x = direction_x

	pos.x = direction_x * speed
	set_velocity(pos)
	move_and_slide()
	pos = velocity


func jumping() -> void:
	if Input.is_action_just_pressed("ui_up") and can_jump:
		pos.y = jump_force / 2
		$JumpFX.play()
	elif is_on_floor():
		can_jump = false


func animation() -> void:
	var anim = "Idle"

	if pos.x != 0:
		anim = "Walk"
	
	if pos.y < 0:
		anim = "Jump"
	
	if pos.y > 0:
		anim = "Fall"

	if life <= 0:
		anim = "Death"
		
	if has_won:
		anim = "Won"

	if $Anim.assigned_animation != anim:
		$Anim.play(anim)


func death() -> void:
	if life <= 0 and Global.chances > 0:
		speed = 0 
		jump_force = 0
		collision_shape.disabled = true
		var new_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
		new_tween.tween_property(self, "global_position:y", 150, 0.5)
		new_tween.tween_interval(0.2)
		new_tween.tween_property(self, "global_position:y", 600, 1.5)
		get_tree().call_group("Dangers", "queue_free")
		get_parent().get_node("HUD/Anim").play("Chances")

	if life <= 0 and Global.chances <= 0:
		speed = 0 
		jump_force = 0
		collision_shape.disabled = true
		var new_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
		new_tween.tween_property(self, "global_position:y", 150, 0.5)
		new_tween.tween_interval(0.2)
		new_tween.tween_property(self, "global_position:y", 600, 1.5)
		get_tree().call_group("Dangers", "queue_free")
		get_parent().get_node("HUD/Anim").play("GameOver")


func _on_detector_body_entered(body: Node2D) -> void:
	if body:
		$DeathFX.play()
		life -= 1 


func _on_coyote_timer_timeout() -> void:
	can_jump = false
