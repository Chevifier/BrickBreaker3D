extends Node2D

signal data_saved
signal data_loaded;
const SAVE_DIR = "user://saves/"
var my_password = "0123456789"

#for testing
var data = {
	"high_score": 0
}

var file_path = SAVE_DIR + "save.dat"
var loaded_data;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func save_data(data):
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var save_file = File.new()
	#save file without encryption
	#save_file.open(file_path,File.WRITE)
	#save with encryption
	save_file.open_encrypted_with_pass(file_path,File.WRITE,my_password)
	
	save_file.store_var(data)
	save_file.close()
	emit_signal("data_saved")
	
func load_data():
	var save_file = File.new()
	if save_file.file_exists(file_path):
		save_file.open_encrypted_with_pass(file_path,File.READ,my_password)
		#save_file.open(file_path,File.READ)
		data = save_file.get_var()
		save_file.close()
		emit_signal("data_loaded")
		return loaded_data
