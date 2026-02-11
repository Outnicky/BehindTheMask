class_name  PlayerJump extends Actions

const JUMP_VELOCITY =-450.0
const jump_time = 0.1
const jump_cooldown = 0.6

func get_name() -> String:
	return "Jump"

func can_swap_into() -> bool:
	var player = entity as Player
	return player.double_jump

func jump(delta):
	var player = entity as Player
	entity.velocity.y = JUMP_VELOCITY
	if !entity.is_on_floor(): 
		player.double_jump  = false
	
func start():
	super.start()
	print("jumpu ")
	jump(1)
func move( delta):
	return
	#jump(delta)


func update(delta):
	pass
