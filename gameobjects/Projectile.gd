extends Area

export var speed = 40


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	global_transform.origin.y += speed * delta


func _on_Projectile_body_entered(body):
	if body.is_in_group("bricks"):
		body.remove_brick()
		GameManager.add_score(5)
		queue_free()


func _on_Timer_timeout():
	queue_free()
