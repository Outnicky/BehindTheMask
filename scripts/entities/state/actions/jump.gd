class_name  PlayerJump extends Actions

const JUMP_VELOCITY =-450.0
const jump_time = 0.1
const jump_cooldown = 0.6

func get_name() -> String:
	return "Jump"

func can_swap_into(ctx) -> bool:
	return ctx.owner.double_jump



func start_physics(ctx, out: PhysicsOutput):
	if !ctx.owner.is_on_floor():
		ctx.owner.double_jump  = false
	out.direction.y = 1
	out.velocity.y = JUMP_VELOCITY

func update(delta):
	pass
