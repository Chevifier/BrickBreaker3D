extends RigidBody


export var min_velocity = 18
export var max_velocity = 20
onready var hit_sound = $hit_sound
onready var brick_sound = $brick_sound
onready var camera_rot = get_parent().get_node("Camera/Camera_Rot")
var control_force = 1000
var can_control = false
func _ready():
	can_control = false
	GameManager.ball_count += 1
	add_to_group("ball")
	set_linear_velocity(Vector3(rand_range(-1,1)*max_velocity,max_velocity,rand_range(-1,1)*max_velocity))
	
	
	
func _physics_process(delta):
	update_input()
	if linear_velocity.length() < min_velocity or linear_velocity.length() > max_velocity:
		var new_velocity = linear_velocity.normalized()
		new_velocity *= max_velocity
		set_linear_velocity(new_velocity)
	

func enable_control(controlable):
	can_control = controlable
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

	direction.y = 1
	add_central_force(direction.normalized() * control_force)
	#test git 2

func _on_RigidBody_body_entered(body):
	if body.is_in_group("bricks"):
		GameManager.add_score(10)
		#play particle effect
		body.start_distroy()
		brick_sound.play()
	else:
		hit_sound.play()
