extends CharacterBody2D

		
func _on_area_2d_body_entered(body):
	if body.has_method("fox") and Global.crow_fi:
		Dialogic.start("crow_timeline")
		Dialogic.timeline_ended.connect(Global.end_dialog)
		Global.in_dialog = true 	
		Global.crow_fi = false

			

	

