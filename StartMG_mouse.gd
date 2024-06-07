extends Node2D
var specific_scene_instance: PackedScene = load("res://the_forest_1.tscn")
var fox = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Action") and fox and !Global.in_dialog:
		if !Global.mg_won:
			Global.auto_save_game()
			get_tree().change_scene_to_file("res://mg_mouse.tscn")
			Global.mini_game = true

		elif Global.mg_won:
			Dialogic.start("mouse_mg_timeline")
			Dialogic.timeline_ended.connect(Global.end_dialog)
			Global.in_dialog = true		
		

func _on_area_2d_body_entered(body):
	if body.has_method("fox"):
		fox = true
	if body.has_method("fox") and Global.mouse_fi:
		Dialogic.start("mouse_timeline")
		Dialogic.timeline_ended.connect(Global.end_dialog)
		Global.in_dialog = true 	
		Global.mouse_fi = false	
		
	elif body.has_method("fox") and Global.mg_won:
		Dialogic.start("mouse_mg_timeline")
		Dialogic.timeline_ended.connect(Global.end_dialog)
		Global.in_dialog = true
		
	elif body.has_method("fox") and !Global.mg_won:
		Dialogic.start("mouse_ask_timeline")
		Dialogic.timeline_ended.connect(Global.end_dialog)
		Global.in_dialog = true 	
		

func _on_area_2d_body_exited(body):
	if body.has_method("fox"):
		fox = false

	
