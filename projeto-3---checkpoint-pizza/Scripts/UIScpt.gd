extends Control


func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	$ScoreBox/MaxScoreN.text = str(HudScpt.max_score)
	$VBoxContainer/Play.grab_focus()
	HudScpt.chances = 3


func _physics_process(delta: float) -> void:
	$ParallaxBackground/Nuvens.motion_offset.x -= 1.15


func _on_play_pressed() -> void:
	$Anim.play("Change")
	$VBoxContainer/Play.disabled = true
	$VBoxContainer/Credits.disabled = true
	$ButtonFX.play()
	await get_tree().create_timer(2.0).timeout
	Fade.change_scene("res://Scenes/Main.tscn")


func _on_credits_pressed() -> void:
	$Anim.play("Change")
	$VBoxContainer/Play.disabled = true
	$VBoxContainer/Credits.disabled = true
	$ButtonFX.play()
	await get_tree().create_timer(2.0).timeout
	Fade.change_scene("res://Scenes/Credits.tscn")
