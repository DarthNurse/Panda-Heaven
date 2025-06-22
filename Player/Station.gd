extends Node2D

@export var max_health := 1000
@export var fire_rate := 1.0
@export var bullet_scene := preload("res://Player/Bullet.tscn")

var current_health := max_health
var shoot_timer := 0.0

func _ready():
	print("Station initialized with health:", current_health)

func _physics_process(delta):
	shoot_timer -= delta
	if shoot_timer <= 0:
		var nearest = find_nearest_enemy()
		print("Nearest enemy found:", nearest)
		if nearest:
			fire_bullet(nearest)
			shoot_timer = fire_rate

func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		die()

func die():
	print("The station has fallen!")
	# TODO: Add explosion, slow-mo, scene change, etc.

func find_nearest_enemy():
	var nearest = null
	var min_dist = INF
	for child in get_parent().get_children():
		if child is Node2D and child.has_method("take_damage"):
			var dist = global_position.distance_to(child.global_position)
			if dist < min_dist:
				min_dist = dist
				nearest = child
	return nearest

func fire_bullet(target):
	print("FIRING BULLET at:", target.name)
	var bullet = bullet_scene.instantiate()

	var gun_point = $GunPoint.global_position
	var target_point = target.global_position
	
	bullet.global_position = gun_point
	bullet.direction = (target_point - gun_point).normalized()

	get_parent().add_child(bullet)
