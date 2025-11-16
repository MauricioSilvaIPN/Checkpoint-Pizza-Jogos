extends Node2D

@export var danger : PackedScene

@onready var initial_position = $ObstaclesContainer/Obstacles.position.x


func _ready() -> void:
	HudScpt.score = 0
	HudScpt.chances = HudScpt.chances
	platform_generator(20)
	$HUD.start_game()


func _physics_process(delta: float) -> void:
	if HudScpt.score > HudScpt.max_score:
		HudScpt.max_score = HudScpt.score

	$HUD/Score.text = str(HudScpt.score)
	$HUD/ChancesBox/ChancesN.text = str(HudScpt.chances)
	
	if $Uirapuru != null:
		$Camera2D.global_position.x = $Uirapuru.global_position.x

	if $HUD.can_play == false:
		$Uirapuru.set_physics_process(false)
	else:
		$Uirapuru.set_physics_process(true)
	
	if HudScpt.score >= 20:
		$Uirapuru.speed = 200
	
	if HudScpt.score >= 40:
		$Uirapuru.speed = 250
	
	if HudScpt.score >= 80:
		$Uirapuru.speed = 300


func platform_generator(amount) -> void:
	for number in amount:
		initial_position += randf_range(200, 150)
		
		var new_danger = danger.instantiate()
		new_danger.position = Vector2(initial_position, randf_range(-50, 85))
		get_node("ObstaclesContainer").call_deferred("add_child", new_danger)



func _on_platform_delete_area_entered(area: Area2D) -> void:
	if area:
		platform_generator(1)


func _on_uirapuru_player_death() -> void:
	if HudScpt.chances > 0:
		$HUD.can_play = false
		HudScpt.chances -= 1
		$HUD.low_chances()

	if HudScpt.chances <= 0:
		$HUD.game_over()


func _on_fall_zone_body_entered(body: Node2D) -> void:
	if body.name == "Uirapuru" and HudScpt.chances > 0:
		$HUD.can_play = false
		$Uirapuru/DeathFX.play()
		HudScpt.chances -= 1
		$HUD.low_chances()
		body.hide()
		body.jump_force = 0
		body.speed = 0

	if body.name == "Uirapuru" and HudScpt.chances <= 0:
		$HUD.game_over()
