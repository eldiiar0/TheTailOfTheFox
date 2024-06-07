extends Node

var save_path = "user://"
var save_name = "Foxgame.save"
var auto_save = "AutoFoxgame.save"
var first_save = "FirstFoxgame.save"
var mm_load = false
var music = null
var music_pos = 0.00

var in_dialog = false
var mini_game = null
var mg_won = false
var fox = null
var fox_current_atc = false
var branches_collected = 0

var branches = null
var enemies = null
var wolf_damage = 10

var crow_fi = true
var mouse_fi = true
var beaver_fi = true


func end_dialog():
	in_dialog = false 	
	
	
func verify_save_dir(path:String):
	DirAccess.make_dir_absolute(path)
	
	
func save_data():
	var branche_num = 0
	var enemy_num = 0
	var save_dict = {
		"fox_position" : fox.position,
		"fox_health" : fox.health,
		"branches_collected" : branches_collected,
		"mg_won": mg_won,
		"crow_fi": crow_fi,
		"mouse_fi": mouse_fi,
		"beaver_fi": beaver_fi,
		 "music_pos": music.get_playback_position()
		#"branches" : Global.branches
	}
	for branche in branches:
		save_dict["branche_num"+str(branche_num)] = branche.position
		branche_num += 1
	for enemy in enemies:
		save_dict["enemy"+str(enemy_num)] = enemy.position
		enemy_num += 1
	print(save_dict)
	print(save_dict["branches_collected"],save_dict["branche_num1"])
	return save_dict
	

func first_save_game():
	var file = FileAccess.open(save_path + first_save, FileAccess.WRITE)
	file.store_var(save_data())
	
	
func auto_save_game():
	var file = FileAccess.open(save_path + auto_save, FileAccess.WRITE)
	file.store_var(save_data())
	
	
func auto_load_game():
	var content = null
	if FileAccess.file_exists(save_path + auto_save):
		var file = FileAccess.open(save_path + auto_save, FileAccess.READ)
		content = file.get_var()
		fox.position = content["fox_position"]
		fox.health = content["fox_health"] 
		branches_collected = content["branches_collected"]
		#Global.branches = content["branches"]
		crow_fi = content["crow_fi"]
		mouse_fi = content["mouse_fi"]
		beaver_fi = content["beaver_fi"]
		music_pos = content["music_pos"]
		music.play(music_pos)
		var enemy_num = 0
		var branche_num = 0
		for branche in branches:
			branche.position = content["branche_num"+str(branche_num)]
			branche_num +=1
		for enemy in enemies:
			enemy.position = content["enemy"+str(enemy_num)]
			enemy_num += 1
		fox._ready()
		fox.branches_status()
	else:
		print("no file")
	return content
	
func load_game():
	var content = null
	if FileAccess.file_exists(save_path + save_name):
		var file = FileAccess.open(save_path + save_name, FileAccess.READ)
		content = file.get_var()
		fox.position = content["fox_position"]
		fox.health = content["fox_health"] 
		branches_collected = content["branches_collected"]
		mg_won = content["mg_won"]	
		#Global.branches = content["branches"]
		crow_fi = content["crow_fi"]
		mouse_fi = content["mouse_fi"]
		beaver_fi = content["beaver_fi"]
		music_pos = content["music_pos"]
		music.play(music_pos)
		var enemy_num = 0
		var branche_num = 0
		for branche in branches:
			branche.position = content["branche_num"+str(branche_num)]
			branche_num +=1
		for enemy in enemies:
			enemy.position = content["enemy"+str(enemy_num)]
			enemy_num += 1
		fox._ready()
		fox.branches_status()
		
	else:
		print("no file")
	return content
	
func load_first_save():
	var content = null
	if FileAccess.file_exists(save_path + first_save):
		var file = FileAccess.open(save_path + first_save, FileAccess.READ)
		content = file.get_var()
		fox.position = content["fox_position"]
		fox.health = content["fox_health"] 
		branches_collected = content["branches_collected"]
		mg_won = content["mg_won"]	
		#Global.branches = content["branches"]
		crow_fi = content["crow_fi"]
		mouse_fi = content["mouse_fi"]
		beaver_fi = content["beaver_fi"]
		music_pos = content["music_pos"]
		music.play(music_pos)
		var enemy_num = 0
		var branche_num = 0
		for branche in branches:
			branche.position = content["branche_num"+str(branche_num)]
			branche_num +=1
		for enemy in enemies:
			enemy.position = content["enemy"+str(enemy_num)]
			enemy_num += 1
		fox._ready()
		fox.branches_status()
		
	else:
		print("no file")
	return content
