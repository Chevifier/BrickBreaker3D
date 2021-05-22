extends Spatial

export(NodePath) var ball_path
export(NodePath) var player_path

onready var ball = get_node(ball_path)
onready var player = get_node(player_path)
onready var cam_rot = $Camera_Rot
var current_rotation = 0


func _physics_process(delta):
	if Input.is_action_just_pressed("camera_left"):
		current_rotation -= 90
	elif Input.is_action_just_pressed("camera_right"):
		current_rotation += 90
	
	cam_rot.rotation_degrees.y = lerp(cam_rot.rotation_degrees.y,current_rotation, 0.02)
