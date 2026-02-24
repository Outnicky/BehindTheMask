class_name Fall extends Movement

func get_name() -> String:
	return "Fall"

func move(ctx : Context, out : PhysicsOutput):
	super.move(ctx, out)
	out.speed.y = 20
	#out.speed_multiplayer.y = FALL_MULTIPLIER
func is_over(ctx) -> bool:
	return true
