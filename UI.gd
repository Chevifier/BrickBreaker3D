extends CanvasLayer

onready var score_label = $Main/score_label

onready var main = $Main
onready var pause = $Paused
onready var game_over = $Game_Over
onready var level_complete = $Level_Complete
onready var wave_label = $Main/wave_label


onready var top_score_label = $Game_Over/VBoxContainer2/top_score
onready var last_score_label = $Game_Over/VBoxContainer2/last_score
export(NodePath) var brick_contain_path
onready var Brick_container = get_node(brick_contain_path)
var is_level_complete = false
# Called when the node enters the scene tree for the first time.
func _ready():
	wave_label.text = "wave " + str(GameManager.wave)
	Engine.time_scale = 1
	Bgm.filter("master")
	switch_view("main")
	get_tree().paused = false


func _process(delta):
	score_label.text = str(GameManager.score)
	
	if Input.is_action_just_pressed("pause"):
		switch_view("paused")
		get_tree().paused = true
	if Brick_container.get_child_count() == 0 and is_level_complete== false:
		switch_view("level complete")
		Engine.time_scale = 0.5
		$AnimationPlayer.play("change_level")
		is_level_complete = true
	
	
	
	
func game_over():
	$Game_over_sound.play()
	top_score_label.text = str(SaveSystem.data["high_score"])
	if SaveSystem.data["high_score"] < GameManager.score:
		SaveSystem.data["high_score"] = GameManager.score
		top_score_label.text = str(SaveSystem.data["high_score"])
		SaveSystem.save_data(SaveSystem.data)
	last_score_label.text = str(GameManager.score)
	Bgm.filter("filtered")
	switch_view("game over")
	get_tree().paused = true
	
func switch_view(view):
	main.visible = false
	pause.visible = false
	game_over.visible = false
	level_complete.visible = false
	match view:
		"main":
			main.visible = true
		"paused":
			pause.visible = true
		"game over":
			game_over.visible = true
		"level complete":
			level_complete.visible = true
	
func load_next_level():
	GameManager.ball_count = 0
	get_tree().reload_current_scene()
	if GameManager.wave < 10:
		GameManager.increase_wave()

func _on_resume_pressed():
	get_tree().paused = false
	switch_view("main")


func _on_exit_pressed():
	get_tree().quit()


func _on_retry_pressed():
	GameManager.reset()
	get_tree().reload_current_scene()
	
