extends AnimatableBody2D

@export_enum("Sprites/Pixel art - Fatia de queijo", "Sprites/Pixel art - Azeitona", "Sprites/Pixel art - Tomate", "Sprites/Pixel art - Calabresa") var texture_name : Array[String]
@onready var sprite = $Sprite2D


func _ready() -> void:
	choose_texture()


func choose_texture() -> void:
	var default_sprite : String
	var sprite_modifier = randi() % 4

	if sprite_modifier == 0:
		default_sprite = texture_name[0]

	if sprite_modifier == 1:
		default_sprite = texture_name[1]

	if sprite_modifier == 2:
		default_sprite = texture_name[2]

	if sprite_modifier == 3:
		default_sprite = texture_name[3]

	var loading_sprite = load(str("res://", default_sprite, ".png"))
	sprite.texture = loading_sprite


func _on_detector_body_entered(body: Node2D) -> void:
	if body:
		$Detector.queue_free()
