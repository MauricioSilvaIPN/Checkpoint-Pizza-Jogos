extends States

@onready var enemie_inst = get_parent().get_parent()


func enter_state() -> void:
	enemie_inst.emit_signal("boss_defeated")


func update_state(delta) -> void:
	if enemie_inst.has_lost:
		enemie_inst.anim.play("Death")



func exit_state() -> void:
	pass
