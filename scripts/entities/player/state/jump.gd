class_name  PlayerJump extends PlayerState

const JUMP_VELOCITY =-650.0
func get_name() -> String:
	return "Jump"


func jump():
	if player.is_on_floor(): 
		player.velocity.y = JUMP_VELOCITY
	else:
		if player.double_jump== true:
			player.double_jump  = false
			player.velocity.y = JUMP_VELOCITY
func start():
	super.start()
	jump()

func move():
	if is_over():
		super.move()
	else:
		player.move()
func update(delta):
	super.update(delta)
