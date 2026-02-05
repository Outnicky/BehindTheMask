class_name  PlayerDash extends PlayerState

var dash_speed = 1000
var dashing := true
var dashing_timer = 0
var dashing_timeout = 0.4
var dash_cooldown = 1

func get_name()-> String:
	return "Dash"
	

func is_over() -> bool:
	return dashing_timer >= dashing_timeout

func stop():
	super.stop()
	player.collision_mask = 3
	
func can_swap_into()-> bool:
	return player.can_dash
func start():
	super.start()
	player.can_dash = false
	player.collision_mask = 2
	player.get_tree().create_timer(dash_cooldown).timeout.connect(func():
		player.can_dash = true
		)
	
	#player.velocity.x = player.direction * dash_speed

func update(delta):
	player.velocity.x = player.direction * dash_speed
	dashing_timer += delta
	
		
func change_if_over():
	if  dashing_timer> dashing_timeout:
		if new_state:
			player.change_state(new_state)
	

func take_damage(enemy):
	player.audio_manager.play("perfect_dodge")
