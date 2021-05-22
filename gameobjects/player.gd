extends KinematicBody

export (PackedScene) var ball
export (PackedScene) var weapon

export var speed = 10

var speed_offset = 1

export (NodePath) var camera_rot_path
var velocity = Vector3()
onready var camera_rot = get_node(camera_rot_path)

var has_weapon = false
var weapon_count = 0
var has_double_ball = false
var scaled_up = false
var scaled_down = false
var weapon_ins1
var weapon_ins2
var weapon_ins3
var weapon_ins4

var player_alive = true
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	update_input()
func update_input():
	
	var direction = Vector3()
	if Input.is_action_pressed("left"):
		direction -= camera_rot.global_transform.basis.x
	if Input.is_action_pressed("right"):
		direction += camera_rot.global_transform.basis.x
	if Input.is_action_pressed("up"):
		direction -= camera_rot.global_transform.basis.z
	if Input.is_action_pressed("down"):
		direction += camera_rot.global_transform.basis.z
	
	velocity = direction.normalized() * speed * speed_offset
	
	velocity = move_and_slide(velocity)


func _on_Area_body_entered(body):
	if body.is_in_group("ball"):
		$AnimationPlayer.play("bounce")
		body.enable_control(true)


func _on_Area_body_exited(body):
	if body.is_in_group("ball"):
		body.enable_control(false)


func _on_Area_area_entered(area):
	if area.is_in_group("upgrade"):
		add_upgrade(area.type)
		area.queue_free()

func add_upgrade(type):
	if type == GameManager.Upgrade.WEAPON and weapon_count < 4:
		var w = weapon.instance()
		add_child(w)
		
		if weapon_count == 0:
			weapon_ins1 = w
			w.global_transform.origin = $weapon_position.global_transform.origin
		if weapon_count == 1:
			weapon_ins2 = w
			w.global_transform.origin = $weapon_position2.global_transform.origin
		if weapon_count == 2:
			weapon_ins3 = w
			w.global_transform.origin = $weapon_position3.global_transform.origin
		if weapon_count == 3:
			weapon_ins4 = w
			w.global_transform.origin = $weapon_position4.global_transform.origin
		weapon_count += 1
		has_weapon = true
	elif type == GameManager.Upgrade.DOUBLE_BALL:
		var b : RigidBody = ball.instance()
		get_parent().add_child(b)
		b.global_transform.origin = global_transform.origin + Vector3(0,2,0)
		b.apply_central_impulse(Vector3(rand_range(-1,1),rand_range(-1,1),rand_range(-1,1)) * b.max_velocity)
		has_double_ball = true
	elif type == GameManager.Upgrade.EXPANSION:
		if scaled_up == false:
			expand_tween()
			scaled_up = true
			scaled_down = false
	elif type == GameManager.Upgrade.RETRACTION:
		if scaled_down == false:
			retract_tween()
			scaled_down = true
			scaled_up = false
	GameManager.add_score(5)
	$upgrade_pickup.play()
	
func expand_tween():
	$Tween.interpolate_property(self,"scale",scale,Vector3(1.5,1,1.5),0.2)
	$Tween.start()
func retract_tween():
	$Tween.interpolate_property(self,"scale",scale,Vector3(0.5,1,0.5),0.2)
	$Tween.start()
