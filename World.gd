extends Spatial

onready var UI = $UI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if GameManager.ball_count == 0:
		UI.game_over()



func _on_Floor_detection_body_entered(body):
	if body.is_in_group("ball"):
		GameManager.ball_count -= 1
		print(GameManager.ball_count)
		body.queue_free()
		if GameManager.ball_count <= 0:
			UI.game_over()
			
#called in brick generater after level is loaded
func set_world_size(level_depth):
	if level_depth <= 4:
		$world_shaper.play("flat")
	else:
		$world_shaper.play("square")
	
	
	
