class_name Crouch extends State

const CROUCH_SPEED = 150.0
const CROUCH_DOWNARDS_VELOCITY = 550.0

func update(delta):
	if !entity.is_on_floor():
		entity.velocity.y = CROUCH_DOWNARDS_VELOCITY
	entity.velocity.x *= 0.5
	
