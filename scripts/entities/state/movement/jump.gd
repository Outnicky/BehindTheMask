class_name  PlayerJump extends Movement

const JUMP_VELOCITY =300.0
const jump_time = 0.1
const jump_cooldown = 0.6
var velocity_y = JUMP_VELOCITY
func get_name() -> String:
	return "Jump"

func can_swap_into(ctx) -> bool:
	return ctx.owner.double_jump

func is_over(ctx) -> bool:
	return time_elapsed > jump_time

func start_physics(ctx, out: PhysicsOutput):
	super.start_physics(ctx, out)
	if !ctx.owner.is_on_floor():
		ctx.owner.double_jump  = false


func move(ctx : Context, out : PhysicsOutput):
	super.move(ctx, out)
	out.gravity.y = 0
	out.velocity_multiplier.y =0
	out.direction.y = -1

	out.speed.y = velocity_y
func update_physics(ctx: Context, out: PhysicsOutput):
	super.update_physics(ctx,out)
	#if ctx.owner.is_on_floor()and time_elapsed>0.1:
	#	ended = true
	pass
