extends CanvasLayer

var scene : String


func transition_scene() -> void:
	get_tree().change_scene_to_file(scene)


func change_scene(new_scene : String) -> void:
	scene = new_scene
	$Anim.play("Fading")
