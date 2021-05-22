extends Control


onready var color_rect = $ColorRect
var color_rand = Color()
var switch_time = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.reset()
	SaveSystem.load_data()
	randomize()


func _process(delta):
	switch_time -= 1* delta
	if switch_time <= 0:
		color_rand = Color(randf(),randf(),randf(),1)
		switch_time = 2
	color_rect.color = lerp(color_rect.color,color_rand, 0.05)



func _on_Play_pressed():
	get_tree().change_scene("res://World.tscn")
