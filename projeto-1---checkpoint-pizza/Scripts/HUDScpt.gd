extends CanvasLayer

var score := 0
var can_play : bool


func start_game() -> void:
	$Starting.visible = true
	can_play = false
	$Starting.text = "Preparado?"
	await get_tree().create_timer(2.0).timeout
	$Starting.text = "Vai!"
	await get_tree().create_timer(2.0).timeout
	$Starting.visible = false
	can_play = true


func game_over() -> void:
	$Anim.play("GameOver")


func low_chances() -> void:
	$Anim.play("Chances")


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "GameOver":
		$HBoxContainer/Exit.grab_focus()
		$HBoxContainer/Code.visible = true
		$HBoxContainer/Exit.visible = true

	if anim_name == "Chances":
		Fade.change_scene("res://Scenes/Arena.tscn")


func _on_exit_pressed() -> void:
	if $HBoxContainer/Code.text == "CHuirapuru":
		$ButtonFX.play()
		Fade.change_scene("res://Scenes/UI.tscn")
