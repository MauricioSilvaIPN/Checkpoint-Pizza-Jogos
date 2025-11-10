extends Control


func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	Global.player_number = 0
	Global.score = 0
	Global.chances = 3
	$ScoreBox/MaxScoreN.text = str(Global.max_score)
	$VBoxContainer/Play.grab_focus()


func _on_play_pressed() -> void:
	$ButtonFX.play()
	$VBoxContainer/Credits.disabled = true
	$VBoxContainer/Play.disabled = true
	$Anim.play("ChangeScene")
	await get_tree().create_timer(4.0).timeout
	Fade.change_scene("res://Scenes/CharacterSelect.tscn")


func _on_credits_pressed() -> void:
	$ButtonFX.play()
	$VBoxContainer/Credits.disabled = true
	$VBoxContainer/Play.disabled = true
	$Anim.play("ChangeScene")
	await get_tree().create_timer(4.0).timeout
	Fade.change_scene("res://Scenes/Creditos.tscn")
