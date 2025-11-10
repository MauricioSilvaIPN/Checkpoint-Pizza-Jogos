extends CanvasLayer


func _physics_process(delta: float) -> void:
	$ScoreHUD/Score.text = str(Global.score)
	$ChancesBox/ChancesN.text = str(Global.chances)


func game_over() -> void:
	$VBoxContainer/Code.visible = true
	$VBoxContainer/Quit.visible = true
	$VBoxContainer/Quit.grab_focus()


func chances() -> void:
	Global.chances -= 1
	$ChancesBox/ChancesN.text = str(Global.chances)


func won_game() -> void:
	$Anim.play("WonGame")


func _on_quit_pressed() -> void:
	$ButtonFX.play()
	if $VBoxContainer/Code.text == "CHuirapuru":
		Fade.change_scene("res://Scenes/UI.tscn")


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "GameOver":
		game_over()

	if anim_name == "WonGame" and Global.arena_number == 2:
		Fade.change_scene("res://Scenes/Main.tscn")
	
	if anim_name == "WonGame" and Global.arena_number == 1:
		Fade.change_scene("res://Scenes/Main02.tscn")


	if anim_name == "Chances" and Global.arena_number == 1:
		Fade.change_scene("res://Scenes/Main.tscn")
	
	if anim_name == "Chances" and Global.arena_number == 2:
		Fade.change_scene("res://Scenes/Main02.tscn")
