extends CharacterBody2D

		
func _on_area_2d_body_entered(body):
	if body.has_method("fox") and Global.beaver_fi:
		Dialogic.start("beaver_timeline")
		Dialogic.timeline_ended.connect(Global.end_dialog)
		Global.in_dialog = true 	
		Global.beaver_fi = false
	
	elif body.has_method("fox") and !Global.beaver_fi:
		Dialogic.start("beaver_ask_timeline")
		Dialogic.timeline_ended.connect(Global.end_dialog)
		Global.in_dialog = true 	
		
	elif body.has_method("fox") and Global.branches_collected >= 20:
		Dialogic.start("beaver_bc_timeline")
		Dialogic.timeline_ended.connect(Global.end_dialog)
		Global.in_dialog = true
		
	
