extends CharacterBody2D
@warning_ignore("unused_parameter")
@export var health = 100
var fox_awake = true
var speed = 350

var enemy_inatc_range = false
var enemy_atc_cd = true
var can_move = true
var dash_cd = 3.0
var dash_timer = 3.0
var dash_duration = 0.2
var dash_distance = 650.0
var is_dashing = false

var enemy = null

func fox():
	pass
	
func _ready():
	#$CanvasLayer3/HealthBar.value = health
	$CanvasLayer3/TextureHPBar.value = health
	$CanvasLayer3/DashBar.value = dash_timer
	
	
func _physics_process(delta):
	if Global.in_dialog:
		speed = 0
	else:
		speed = 350
	if can_move:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var marker2D = $Marker2D
		var anim = $Marker2D/AnimatedSprite2D
		if health <=0: #add game over
			fox_awake = false 
			health = 0
			game_over()
			print("game over")

		if dash_timer >= dash_cd and Input.is_action_just_pressed("dash"):	
			dash_timer = 0
			is_dashing = true
			# Add dashing animation or effects here
			# anim.play("dash_animation")
			
		# dashisng mech
		if is_dashing:
			var dash_vector = direction.normalized() * dash_distance
			velocity = dash_vector
			Global.fox_current_atc = true
			move_and_slide()
			
			dash_duration -= delta
			if dash_duration <= 0:
				is_dashing = false
				Global.fox_current_atc = false
				dash_duration = 0.2  # Reset dash dur
				
		velocity = direction*speed 
		
		#fliping on move
		if direction.x>0:
			marker2D.scale.x=1
		elif direction.x<0:
			marker2D.scale.x=-1
			
		# Update cd timer
		if dash_timer < dash_cd:
			$CanvasLayer3/DashBar.value = dash_timer
			dash_timer += delta
		enemy_attack()	
		move_and_slide()
	else:
		move_and_collide(velocity)

func _on_fox_atc_body_entered(body):
	if body.has_method("enemy"):
		enemy = body
		enemy_inatc_range = true

		
func _on_fox_atc_body_exited(body):
	if body.has_method("enemy"):
		enemy = null
		enemy_inatc_range = false
		
						
func enemy_attack():
	if enemy_inatc_range and enemy_atc_cd:
		
		if is_dashing == false:
			can_move = false
			self.modulate = Color(1, 0.3569, 0.3569, 1)
			health = health - Global.wolf_damage
			#$CanvasLayer3/HealthBar.value = health
			$CanvasLayer3/TextureHPBar.value = health
			enemy_atc_cd = false
			$atc_cd.start()	
			velocity = (global_position - enemy.get_global_position()).normalized()*10
			velocity = lerp(velocity, Vector2.ZERO, 0.01)
			
			await get_tree().create_timer(0.25).timeout
			can_move = true
			print("fox hp: ",health)


func _on_atc_cd_timeout():
	self.modulate = Color(1,1,1,1)
	enemy_atc_cd = true
	
	
func game_over():
	get_tree().change_scene_to_file("res://game_over.tscn")


func branches_status():
	if Global.branches_collected > 0:
		$CanvasLayer3/BranchesCol.visible = true
		$CanvasLayer3/BranchesCol.text = ": "+ str(Global.branches_collected)
	else:
		$CanvasLayer3/BranchesCol.visible = false

