extends Control

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	get_tree().connect("tree_changed", Callable(self, "_on_tree_changed"))
	$AnimationPlayer.play("StartMenu")
	if FileAccess.file_exists(Global.save_path + Global.save_name):
		$CanvasLayer/Load.visible = true


func _on_play_pressed():
	$CanvasLayer/SGfade.visible = true
	$AnimationPlayer.play("StartGame")
	


func _on_quit_pressed():
	get_tree().quit()


func _on_load_pressed():
	Global.mm_load = true
	print("bedore menu load")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://the_forest_1.tscn")



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "StartGame":
		get_tree().change_scene_to_file("res://intro.tscn")
