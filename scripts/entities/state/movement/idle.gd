class_name Idle extends Movement

func get_name() -> String:
	return "Idle"

func _init():
	force_state = true
func move(ctx, out):
	out.gravity = ctx.owner.get_gravity()
func is_over(ctx) -> bool:
	return true
