extends Node2D

@export var picked = false
var fox = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("PickUp") and fox:
		Global.branches_collected += 1
		print(Global.branches_collected )
		print("Fox picked: ",self,picked)
		picked = true
	if picked:
		self.position = Vector2(-9999,-9995)
		Global.fox.branches_status()


func _on_pick_area_body_entered(body):
	if body.has_method("fox"):
		print("fox in pick area")
		fox = true


func _on_pick_area_body_exited(body):
	if body.has_method("fox"):
		print("fox left area")	
		fox = false
