extends States

@onready var enemie_inst = get_parent().get_parent()



func enter_state() -> void:
	pass


func update_state(delta) -> void:
	if enemie_inst.is_idle:
		enemie_inst.anim.play("Idle")

	if enemie_inst.can_spawn:
		get_parent().change_state("Spawn")

	if enemie_inst.has_lost:
		get_parent().change_state("Death")



func exit_state() -> void:
	pass
