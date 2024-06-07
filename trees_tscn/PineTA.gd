extends AnimatedSprite2D

var animation_timer = Timer.new()
var animation_duration_timer = Timer.new()
var min_interval = 4.0  # Minimum interval between animations (seconds)
var max_interval = 8.0  # Maximum interval between animations (seconds)
var min_duration = 4.0  # Minimum duration of the animation (seconds)
var max_duration = 8.0  # Maximum duration of the animation (seconds)

func _ready():
	# Add the timer as a child of the tree node
	#add_child(animation_timer)
	#add_child(animation_duration_timer)
	## Connect the timeout signal of the timer to a method
	#animation_timer.connect("timeout", _on_timer_timeout)
	#animation_duration_timer.connect("timeout", _on_animation_duration_timeout)
	## Start the timer with a random interval
	#set_next_animation()
	#
	pass	
func set_next_animation():
	# Choose a random interval for the next animation
	var next_interval = randf_range(min_interval, max_interval)
	# Set the timer interval
	animation_timer.wait_time = next_interval
	# Start the timer
	animation_timer.start()

func _on_timer_timeout():
	# Choose a random duration for the animation
	var duration = randf_range(min_duration, max_duration)
	# Play the animation
	play("swing1")
	# Stop the animation after the random duration
	animation_duration_timer.wait_time = duration
	animation_duration_timer.start()
	
	
func _on_animation_duration_timeout():
	#print("Animation duration timer timeout")
	# Stop the animation

	stop()
