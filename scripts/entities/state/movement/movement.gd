class_name Movement extends State


func move(ctx : Context, out : PhysicsOutput):
	if self is Move:
		pass
	if !ctx.owner.is_on_floor():
		out.gravity = ctx.owner.get_gravity() * ctx.delta
		out.direction.y = 1
	if dir.x == -1:
		pass
	out.velocity_multiplier.x = 0
	out.direction.x = dir.x
	out.speed.x = ctx.owner.SPEED
	out.facing_direction = dir.x

func update_process(ctx: Context, out: VisualOutput):
	super.update_process(ctx, out)
	get_animation_state(ctx,out)
