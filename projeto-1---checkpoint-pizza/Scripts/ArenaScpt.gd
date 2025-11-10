extends Node2D

@export var obstacle : PackedScene
@export var enemie : PackedScene
@export var fly_enemie : PackedScene

@onready var initial_platform = $PlatformContainer/Obstaculo.position.y
@onready var camera2d = $Camera2D
@onready var player = $Pizza
@onready var hud = $HUD 


func _ready() -> void:
	hud.score = 0
	Global.chances = Global.chances
	hud.start_game()
	$HUD/GameOver.position.x = 525
	$HUD/HBoxContainer/Exit.visible = false
	camera2d.global_position = player.global_position
	platform_generator(20)
	enemie_generator(2)

	var new_enemie = fly_enemie.instantiate()
	new_enemie.position = Vector2(100.0, -6302.0)
	$PlatformContainer.add_child(new_enemie)


func _physics_process(delta: float) -> void:
	$ParallaxBackground/ParallaxLayer.motion_offset.y += 1.5
	$HUD/ChancesBox/ChancesN.text = str(Global.chances)

	if hud.score > Global.max_score:
		Global.max_score = hud.score

	if hud.can_play == false:
		$Pizza.set_physics_process(false)
		
	if hud.can_play == true:
		$Pizza.set_physics_process(true)

	if hud.score >= 1500:
		$ParallaxBackground/ParallaxLayer/BG.modulate = "1f1d45"


	if player != null:
		if player.position.y < camera2d.position.y:
			hud.score += 1
			$HUD/Text.text = str(hud.score)
			camera2d.position.y = player.position.y


func platform_generator(amount) -> void:
	for number in amount:
		initial_platform -= randf_range(64, 32)
		
		var new_obstacle = obstacle.instantiate()
		new_obstacle.position = Vector2(randf_range(10, 310), initial_platform)
		get_node("PlatformContainer").call_deferred("add_child", new_obstacle)


func enemie_generator(amount) -> void:
	for number in amount:
		initial_platform -= randf_range(64, 32)

		var new_enemie = enemie.instantiate()
		new_enemie.position = Vector2(randf_range(10, 310), initial_platform)
		get_node("PlatformContainer").call_deferred("add_child", new_enemie)


func flyenemie_generator(amount) -> void:
	for number in amount:
		initial_platform -= randf_range(64, 32)

		var new_enemie = fly_enemie.instantiate()
		new_enemie.position = Vector2(randf_range(10, 310), initial_platform)
		get_node("PlatformContainer").call_deferred("add_child", new_enemie)


func implement_difficult(enemie) -> void:
	if enemie.is_in_group("Enemies") and hud.score < 1500:
		enemie_generator(1)
		enemie.queue_free()

	if enemie.is_in_group("Enemies") and hud.score >= 1500:
		enemie_generator(1)
		enemie.queue_free()

	if enemie.is_in_group("FlyEnem") and hud.score >= 1500:
		flyenemie_generator(1)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Obstacles"):
		platform_generator(1)
		body.queue_free()
		
	if body.name == "Pizza":
		$Death.play()
		hud.low_chances()
		Global.chances -= 1

	if Global.chances <= 0 and body.name == "Pizza":
		hud.game_over()
	
	implement_difficult(body)


func _on_pizza_player_death() -> void:
	$Death.play()
	hud.low_chances()
	Global.chances -= 1
	$Pizza/Detector/Col.set_deferred("disabled", true)
	
	if Global.chances <= 0:
		hud.game_over()


func _on_wall_1_body_entered(body: Node2D) -> void:
	if body.name == "Pizza":
		body.position.x = 308.0


func _on_wall_2_body_entered(body: Node2D) -> void:
	if body.name == "Pizza":
		body.position.x = 10.0
