class_name Rise extends Movement

func get_name() -> String:
	return "Rise"

func is_over(ctx) -> bool:
	return true

func move(ctx : Context, out : PhysicsOutput):
	super.move(ctx, out)
	out.direction.y = -1
	out.gravity.y = 20
