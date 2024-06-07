extends CharacterBody2D

var health = 100
var speed = 240
var fox = null
var fox_chase = false
var fox_inatc_range = false
var can_take_dmg = true

@onready var nav_agent = $NavigationAgent2D

var start_position: Vector2
var direction : Vector2
var wander_time = 2

var return_start_pos = false
const RETURN_THRESHOLD = 1.0 
func enemy():
	pass

func _ready():
	start_position = global_position


#func update_wander():
	#if wander_time >= 0:
		#wander_time -= 1
	#else:
		#random_wander()
		
		
func _physics_process(delta):
	velocity = lerp(velocity, Vector2.ZERO, 0.02)
	taking_damage()
	var marker2D = $Marker2D
	if fox_chase:
		
		wander_time=6
		if fox:
			#velocity = (fox.get_global_position() - position).normalized() * speed * delta
			#var direction = (fox.position - position).normalized()
			direction = to_local(nav_agent.get_next_path_position()).normalized()
			velocity = direction * speed * delta
			if direction.x > 0:
				marker2D.scale.x = -1  
			elif direction.x < 0:
				marker2D.scale.x = 1 
	elif return_start_pos:
		
		direction = (start_position - position).normalized() * speed * delta
		velocity = lerp(velocity, direction, 0.2) 
		if direction.x > 0:
			marker2D.scale.x = -1  
		elif direction.x < 0:
			marker2D.scale.x = 1 
		if global_position.distance_to(start_position) < RETURN_THRESHOLD:
			velocity=Vector2.ZERO
			return_start_pos = false
			$SearchCd.stop()
			
	else:
		if wander_time > 0:
			wander_time -= delta
		else:
			print(1)
			random_wander()
			if direction.x > 0:
				marker2D.scale.x = -1  
			elif direction.x < 0:
				marker2D.scale.x = 1 
			
		#if global_position.distance_to(start_position) < RETURN_THRESHOLD:
			#velocity=Vector2.ZERO
			

			#global_position = global_position.lerp(start_position.normalized(), 1* delta)
	#print(global_position.x, "  __  ", start_position.x)
	
	move_and_collide(velocity)

func random_wander():
	#print(velocity)
	#direction = Vector2(randf_range(-1, 1),randf_range(-1,1)).normalized()
	#velocity = direction  * speed/30
	#if self.velocity.x == 0:
	direction = Vector2(randf_range(-1, 1),randf_range(-1,1)).normalized() * speed
	velocity = lerp(velocity, direction, 0.02) 
	wander_time = randf_range(4,8)
	if global_position.x > (start_position.x + 200) or global_position.x < (start_position.x - 200):
		return_start_pos = true
	print(wander_time,velocity)
	
	
func update_target():
	print(fox)
	nav_agent.target_position = fox.position
	print("update")
	#random_wander()
	
	
func _on_search_cd_timeout():
	return_start_pos = true
	print("searching time out")

	
func _on_detect_area_2d_body_entered(body):
	fox = body
	fox_chase = true
	update_target()
	return_start_pos = false
	

func _on_timer_timeout():
	update_target()
	
		
func _on_detect_area_2d_body_exited(body):
	fox = null
	fox_chase = false
	print("fox left")
	$SearchCd.start()
		

func _on_enemy_atc_body_entered(body):
	if body.has_method("fox"):
		fox_inatc_range = true


func _on_enemy_atc_body_exited(body):
	if body.has_method("fox"):
		fox_inatc_range = false


func taking_damage():
	if fox_inatc_range and Global.fox_current_atc:
		if can_take_dmg:
			var fox_chase_state = fox_chase
			fox_chase = false
			$TakeDmgCd.start()
			#speed = 0
			can_take_dmg = false
			health = health - 20
			print("wolf hp: ", health)
			print("wolf speed: ", speed)
			velocity = (global_position - fox.global_position).normalized() * 8
			await get_tree().create_timer(0.7).timeout
			fox_chase = fox_chase_state
		if health <= 0:
			self.queue_free()
		

func _on_take_dmg_cd_timeout():
	can_take_dmg = true
	speed = 250


