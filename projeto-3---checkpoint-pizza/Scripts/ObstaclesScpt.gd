extends Area2D

var score := 0
var pos = Vector2.ZERO


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Uirapuru":
		HudScpt.score += 1
