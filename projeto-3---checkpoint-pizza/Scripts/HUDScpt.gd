extends CanvasLayer

var score := 0
var max_score : int
var chances := 3
var can_play : bool


func game_over() -> void:
	$Anim.play("GameOver")


func start_game() -> void:
	can_play = false
	$Starting.visible = true
	await get_tree().create_timer(2.0).timeout
	$Starting.text = "Vai"
	await  get_tree().create_timer(1.0).timeout
	$Starting.visible = false
	can_play = true


func low_chances() -> void:
	$Anim.play("Chances")


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "GameOver":
		$VBoxContainer/Back.grab_focus()
		$VBoxContainer/Code.visible = true
		$VBoxContainer/Back.visible = true
	
	if anim_name == "Chances":
		Fade.change_scene("res://Scenes/Main.tscn")


func _on_back_pressed() -> void:
	$ButtonFX.play()

	if $VBoxContainer/Code.text == "CHuirapuru":
		Fade.change_scene("res://Scenes/UI.tscn")
