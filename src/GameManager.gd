extends Node

var score = 0
var wave = 1

var player_lives = 3
var ball_count = 0

enum Upgrade {
	NONE,
	EXPANSION,
	RETRACTION,
	WEAPON,
	DOUBLE_BALL
}

func add_score(amount):
	score += amount


func increase_wave():
	wave += 1
	
func reset():
	player_lives = 3
	ball_count = 0
	score = 0
	wave = 1
