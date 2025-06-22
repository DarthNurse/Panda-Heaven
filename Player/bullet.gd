extends Area2D

@export var speed := 100
@export var direction := Vector2.ZERO


func _physics_process(delta):
	position += direction * speed * delta
	
		

func _on_Bullet_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(1)
	queue_free()
	print("Bullet hit something: ", body.name)

func _ready():
	connect("body_entered", Callable(self, "_on_Bullet_body_entered"))
