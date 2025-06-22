extends Node2D

@onready var spawn_timer = $EnemySpawnTimer
@onready var spawn_marker = $SpawnMarker1
@onready var station = $Station

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_enemy()
	spawn_timer.start()

func spawn_enemy():
	var enemy_scene = preload("res://Enemies/Enemy1.tscn")
	var enemy = enemy_scene.instantiate()
	
	# Random X position along top of screen (change later for circle)
	var rand_x = randi_range(100, 1000)
	enemy.global_position = Vector2(rand_x, -100)

	add_child(enemy)
