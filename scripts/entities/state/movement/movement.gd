class_name Movement extends State


func move(ctx : Context, out : PhysicsOutput):
	if !ctx.owner.is_on_floor():
		out.gravity = ctx.owner.get_gravity().y
	out.direction.x = dir.x
	out.speed.x = ctx.owner.SPEED
	out.facing_direction = out.direction.x
	
