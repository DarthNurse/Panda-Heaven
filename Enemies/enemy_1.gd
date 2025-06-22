extends Node2D

@export var speed := 100.0
var target: Node2D

func _ready():
	target = get_parent().get_node("Station") as Node2D
	if not target:
		print("Warning: No target found!")

func _physics_process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		position += direction * speed * delta
