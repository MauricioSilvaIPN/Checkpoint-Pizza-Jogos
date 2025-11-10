extends Node2D

@export var player_one : PackedScene
@export var player_two : PackedScene


func _ready() -> void:
	implement_difficult()
	get_tree().call_group("Dangers", "queue_free")

	Global.score = Global.score
	Global.chances = Global.chances

	if Global.player_number == 1:
		var new_player = player_one.instantiate()
		new_player.global_position = Vector2(439, 417)
		add_child(new_player)

	if Global.player_number == 2:
		var new_player = player_two.instantiate()
		new_player.global_position = Vector2(439, 417)
		add_child(new_player)
		
	if self.name == "Main02":
		Global.arena_number = 2
	else:
		Global.arena_number = 1


func _physics_process(delta: float) -> void:
	if Global.score > Global.max_score:
		Global.max_score = Global.score


func implement_difficult() -> void:
	if Global.score > 1500:
		$PizzaBoss/SpawnTimer.wait_time = 3
	
	if Global.score > 3500:
		$CheeseContainer.visible = true
		$CheeseContainer/Queijo/Col.disabled = false
		$CheeseContainer/Queijo2/Col.disabled = false
		$CheeseContainer/Queijo3/Col.disabled = false
		$CheeseContainer/Queijo4/Col.disabled = false
		$CheeseContainer/Queijo5/Col.disabled = false
		$CheeseContainer/Queijo6/Col.disabled = false
		$CheeseContainer/Queijo7/Col.disabled = false
		$PizzaBoss/SpawnTimer.wait_time = 2


func _on_detector_body_entered(body: Node2D) -> void:
	if body:
		body.queue_free()


func _on_pizza_boss_boss_defeated() -> void:
	Global.score += 500
	$HUD/ScoreHUD/Score.text = str(Global.score)
	$HUD.won_game()
	get_tree().call_group("Dangers", "queue_free")
