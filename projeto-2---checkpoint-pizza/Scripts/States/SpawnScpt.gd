extends States

@onready var enemie_inst = get_parent().get_parent()


func enter_state() -> void:
	pass


func create_dangers() -> void:
	if Global.arena_number == 1:
		var new_danger = enemie_inst.dangers.instantiate()
		new_danger.global_position = Vector2(71, 135)
		get_tree().root.add_child(new_danger)
	else:
		var new_danger = enemie_inst.dangers.instantiate()
		new_danger.global_position = Vector2(393, 135)
		get_tree().root.add_child(new_danger)
		enemie_inst.scale.x *= -1
		new_danger.direction = enemie_inst.scale.x
		new_danger.raycast.scale.x = -enemie_inst.scale.x


func update_state(delta) -> void:
	if enemie_inst.can_spawn:
		enemie_inst.anim.play("Spawn")

	if enemie_inst.is_idle:
		get_parent().change_state("Idle")

	if enemie_inst.has_lost:
		get_parent().change_state("Death")


func exit_state() -> void:
	pass
