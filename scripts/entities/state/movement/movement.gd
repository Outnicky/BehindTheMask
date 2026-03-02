class_name Movement extends State



func move(ctx : Context, out : PhysicsOutput):
	var dir = ctx.move_direction
	if self is PlayerJump :
		pass
	if !ctx.owner.is_on_floor():
		out.gravity = ctx.owner.get_gravity() * ctx.delta
	else:
		out.direction.y = 0
	out.velocity_multiplier.x = 0
	out.direction.x = dir.x
	out.speed.x = ctx.owner.SPEED
	out.facing_direction = dir.x

func update_process(ctx: Context, out: VisualOutput):
	super.update_process(ctx, out)
	get_animation_state(ctx,out)
