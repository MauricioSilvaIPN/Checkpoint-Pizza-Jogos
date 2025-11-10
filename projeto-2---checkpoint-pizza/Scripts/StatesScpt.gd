class_name States
extends Node2D

var default_state = null


func change_state(new_state) -> void:
	if default_state:
		default_state.exit_state()
	default_state = get_node(new_state)
	default_state.enter_state()


func update_state(delta) -> void:
	if default_state:
		default_state.update_state(delta)
