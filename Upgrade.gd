extends Spatial

var fall_speed = 4

export(Array, Texture) var upgrade_icons
var texture_set = false
var type
onready var sprite = $Sprite3D
var camera_loc
# Called when the node enters the scene tree for the first time.
func _ready():
	camera_loc = get_viewport().get_camera()
	add_to_group("upgrade")
	if type == GameManager.Upgrade.EXPANSION:
		sprite.texture = upgrade_icons[0]
	elif type == GameManager.Upgrade.RETRACTION:
		sprite.texture = upgrade_icons[1]
	elif type == GameManager.Upgrade.DOUBLE_BALL:
		sprite.texture = upgrade_icons[2]
	elif type == GameManager.Upgrade.WEAPON:
		sprite.texture = upgrade_icons[3]


func _physics_process(delta):
	sprite.look_at(camera_loc.global_transform.origin, Vector3.UP)
	global_transform.origin.y -= fall_speed * delta
	if texture_set == true:
		return
	if type == GameManager.Upgrade.EXPANSION:
		sprite.texture = upgrade_icons[0]
	elif type == GameManager.Upgrade.RETRACTION:
		sprite.texture = upgrade_icons[1]
	elif type == GameManager.Upgrade.DOUBLE_BALL:
		sprite.texture = upgrade_icons[2]
	elif type == GameManager.Upgrade.WEAPON:
		sprite.texture = upgrade_icons[3]
	texture_set = true


func _on_Upgrade_body_entered(body):
	if body.name == "ground":
		queue_free()
