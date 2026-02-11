class_name Dash extends State

var dash_speed = 1300
var dashing := true
var dashing_timer = 0
var dashing_timeout = 0.2
var dash_cooldown = 1
var dash_direction = 1
func _init():
	block_movement = true
	only_primary = true

func attach(e):
	super.attach(e)
#	dash_direction = e.direction
func get_name()-> String:
	return "Dash"
	
func move(delta):
	entity.velocity.x = entity.direction * dash_speed
func is_over() -> bool:
	#print(dashing_timer)
	return dashing_timer >= dashing_timeout

func stop():
	super.stop()
	entity.collision_mask = 3
	
func can_swap_into()-> bool:
	return entity.can_dash
func start():
	super.start()
	var player = entity as Player
	player.can_dash = false
	player.collision_mask = 2
	player.get_tree().create_timer(dash_cooldown).timeout.connect(func():
		player.can_dash = true
		)
	
	#player.velocity.x = player.direction * dash_speed

func update(delta):
	dashing_timer += delta
	print(dashing_timer)
		

func take_damage(enemy):
	entity.audio_manager.play("perfect_dodge")
