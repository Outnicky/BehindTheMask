class_name  PlayerJump extends State

const JUMP_VELOCITY =-450.0
const jump_time = 0.1
var first_time = false
func get_name() -> String:
	return "Jump"

func can_swap_into() -> bool:
	var player = entity as Player
	return player.double_jump

func jump():
	var player = entity as Player
	if entity.is_on_floor(): 
		entity.velocity.y = JUMP_VELOCITY
	else:
		if player.double_jump== true:
			player.double_jump  = false
			player.velocity.y = JUMP_VELOCITY
func start():
	super.start()
	jump()
	print("jump")
func move(delta):
	jump()

func _init(e):
	super._init(e)
	dir = Vector2(0,-1)

func update(delta):
	entity.apply_gravity(delta)
	
