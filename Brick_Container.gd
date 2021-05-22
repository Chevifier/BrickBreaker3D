extends Spatial


var level_texture

export(Texture) var test_level
export(PackedScene) var bricks_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level(GameManager.wave)
func load_level(wave):
	level_texture = load("res://imports/levels/level_"+str(wave)+".png")
	#level_texture = test_level
	
	var image = level_texture.get_data()
	var image_width = image.get_width()
	var image_height = image.get_height()
	var level_depth = 0
	
	image.lock()
	for i in image_width:
		if image.get_pixel(i,0) != Color(0,0,0,1):
			level_depth += 1
			
	global_transform.origin.x -= image_width/2
	global_transform.origin.z -= level_depth/2
	
	
	#print(image.get_pixel(1,1))
	var x_pos = 0
	var y_pos = 0
	var z_pos = 0
	for z in level_depth:
		for y in image_height:
			if y != 0:
				y_pos = y
				for x in image_width:
					x_pos = x
					if image.get_pixel(x_pos,y_pos) != Color(0,0,0,1):
						var brick = bricks_scene.instance()
						add_child(brick)
						brick.global_transform.origin = global_transform.origin + Vector3(x_pos,y_pos,z_pos)
						brick.set_color(image.get_pixel(x_pos,y_pos))
				x_pos = 0
			
		z_pos += 1
#
	image.unlock()
	get_parent().set_world_size(level_depth)

func _process(delta):
	if get_child_count() <= 2:
		remove_remaining()
func remove_remaining():
	for brick in get_children():
		brick.remove_brick()
	
