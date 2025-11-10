extends CanvasLayer

var scene = ""

func transition() -> void:
	$BG.position.x = -480
	var new_transition = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	new_transition.tween_property($BG, "position:x", 0, 1.0)
	new_transition.tween_interval(1.0)
	new_transition.tween_property($BG, "position:x", 480, 1.0)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file(scene)
	

func change_scene(new_scene : String) -> void:
	scene = new_scene
	transition()
	
