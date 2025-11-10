extends CharacterBody2D

@export var speed := 200
@export var jump_force := -1220
@export var life := 1

@onready var colisor = $Detector/Col

var pos := Vector2.ZERO
var gravity = 1200

signal player_death


func _physics_process(delta: float) -> void:
	movement()
	animation()
	
	pos.y += gravity * delta
	

	if is_on_floor():
		pos.y = jump_force / 2


func movement() -> void:
	var direction_x = int(Input.is_action_pressed("ui_right")) -int(Input.is_action_pressed("ui_left"))
	
	if direction_x != 0:
		$Sprite2D.scale.x = direction_x
	
	pos.x = direction_x * speed
	set_velocity(pos)
	move_and_slide() 
	pos = velocity


func animation() -> void:
	var anim := ""
	
	if is_on_floor():
		$Jump.play()
		anim = "Jump"


	if $Anim.assigned_animation != anim:
		$Anim.play(anim)


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Jump":
		$Anim.play("Fly")


func _on_detector_body_entered(body: Node2D) -> void:
	if body:
		$Death.play()
		$Jump.stop()
		emit_signal("player_death")
		pos.y = 0
		pos.x = 0
		jump_force = 0
		gravity = 0
		speed = 0
		hide()

	if body.is_in_group("FlyEnem"):
		body.set_physics_process(false)
