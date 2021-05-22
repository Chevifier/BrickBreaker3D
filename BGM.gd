extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	playing = true


func change_volume(volume):
	volume_db = volume
	
func filter(_bus):
	bus = _bus
