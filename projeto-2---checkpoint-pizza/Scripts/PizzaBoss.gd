extends CharacterBody2D

@export var dangers : PackedScene

@onready var anim = $Anim
@onready var player_ref : CharacterBody2D = null

var is_idle := true
var can_spawn := false
var has_lost := false

signal boss_defeated


func _ready() -> void:
	#if player_ref != null:
	$States.change_state("Idle")


func _physics_process(delta: float) -> void:
	$States.update_state(delta)
	
	if player_ref != null:
		player_ref = get_parent().get_node("Player")
	
	if player_ref != null:
		if player_ref.has_won:
			has_lost = true
			is_idle = false
			can_spawn = false

	if player_ref != null:
		if player_ref.life <= 0:
			has_lost = false
			is_idle = false
			can_spawn = false


func _on_spawn_timer_timeout() -> void:
	$SpawnTimer.stop()
	$IdleTimer.start()
	is_idle = false
	can_spawn = true


func _on_idle_timer_timeout() -> void:
	$SpawnTimer.start()
	$IdleTimer.stop()
	is_idle = true
	can_spawn = false
