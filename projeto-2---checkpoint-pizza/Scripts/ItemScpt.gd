extends Area2D

@onready var boss_inst : CharacterBody2D = null


func _ready() -> void:
	boss_inst = get_parent().get_node("PizzaBoss")


func _on_body_entered(body: Node2D) -> void:
	if body:
		hide()
		boss_inst.has_lost = true
		body.jump_force = 0
		body.speed = 0
		body.has_won = true
