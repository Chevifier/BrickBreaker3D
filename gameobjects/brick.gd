extends StaticBody

export(PackedScene) var upgrade_scene
onready var brick_mesh = $brick
export var pre_gen_brick_for_imission = false

var upgrade = GameManager.Upgrade.NONE
func _ready():
	randomize()
	add_to_group("bricks")
	if pre_gen_brick_for_imission:
		$AnimationPlayer.play("destroy")
	#debug_get_upgrade()
	generate_upgrade_chance()

func generate_upgrade_chance():
	var rand = randf()*100
	if rand > 84 and rand < 88:
		upgrade = GameManager.Upgrade.EXPANSION
	elif rand >= 88 and rand < 92:
		upgrade = GameManager.Upgrade.RETRACTION
	elif rand >= 92 and rand < 96:
		upgrade = GameManager.Upgrade.WEAPON
	elif rand >= 96 and rand < 100:
		upgrade = GameManager.Upgrade.DOUBLE_BALL


func debug_get_upgrade():
	upgrade = GameManager.Upgrade.DOUBLE_BALL

func start_distroy():
	$AnimationPlayer.play("destroy")


func remove_brick():
	if upgrade != GameManager.Upgrade.NONE:
		var upgde = upgrade_scene.instance()
		get_parent().get_parent().add_child(upgde)
		upgde.type = upgrade
		upgde.global_transform.origin = global_transform.origin
	#drop upgrade
	if pre_gen_brick_for_imission:
		return
	queue_free()
	
	
	


func set_color(color):
	var mat = brick_mesh.get_surface_material(0)
	mat.albedo_color = color
	mat.emission = color
