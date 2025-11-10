extends Control


func _ready() -> void:
	$Back.grab_focus()


func _on_back_pressed() -> void:
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/UI.tscn")
