extends Spatial

export(PackedScene) var projectile_scene

var can_shoot = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("weapon") and can_shoot:
		$weapon_fire.play()
		var p = projectile_scene.instance()
		get_parent().get_parent().add_child(p)
		p.global_transform.origin = $Position3D.global_transform.origin
		$Timer.start(0.5)
		can_shoot = false


func _on_Timer_timeout():
	can_shoot = true
