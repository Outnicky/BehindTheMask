class_name Crouch extends Stance

const CROUCH_SPEED = 150.0
const CROUCH_DOWNARDS_VELOCITY = 700.0
func get_name()-> String:
	return "Crouch"

func move(ctx : Context, out : PhysicsOutput):
	super.move(ctx, out)
	out.speed.x =   CROUCH_SPEED
	if !ctx.owner.is_on_floor():
		out.speed.y = -CROUCH_DOWNARDS_VELOCITY
