extends Control


func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	$HBoxContainer/Play.grab_focus()
	$ScoreBox/MaxScoreN.text = str(Global.max_score)
	Global.chances = 3


func _on_play_pressed() -> void:
	$Anim.play("Change")
	$ButtonFX.play()
	$HBoxContainer/Credits.disabled = true
	$HBoxContainer/Play.disabled = true
	await get_tree().create_timer(2.0).timeout
	Fade.change_scene("res://Scenes/Arena.tscn")


func _on_credits_pressed() -> void:
	$Anim.play("Change")
	$ButtonFX.play()
	$HBoxContainer/Credits.disabled = true
	$HBoxContainer/Play.disabled = true
	await get_tree().create_timer(2.0).timeout
	Fade.change_scene("res://Scenes/Credits.tscn")
