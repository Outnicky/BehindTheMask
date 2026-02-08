class_name  PlayerMove extends Move


const CROUCH_SPEED = 150.0
const CROUCH_DOWNARDS_VELOCITY = 550.0

func _init(e):
	super._init(e)
	SPEED = 250
func move(delta):
	if entity.is_crouching():
		if !entity.is_on_floor():
			entity.velocity.y = CROUCH_DOWNARDS_VELOCITY
		entity.velocity.x = CROUCH_SPEED * dir.x 
	else:
		entity.velocity.x = dir.x  * SPEED
func get_name() -> String:
	return "Walk"

func setup(opts: Dictionary = {}) -> State:
	dir = opts["dir"]
	return self
func is_over() -> bool:
	return true
	
