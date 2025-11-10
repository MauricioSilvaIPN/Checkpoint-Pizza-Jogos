extends Control


func _ready() -> void:
	$Player01.grab_focus()


func _on_player_01_pressed() -> void:
	Global.player_number = 1
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/Main.tscn")


func _on_player_02_pressed() -> void:
	Global.player_number = 2
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/Main.tscn")


func _on_back_pressed() -> void:
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/UI.tscn")
