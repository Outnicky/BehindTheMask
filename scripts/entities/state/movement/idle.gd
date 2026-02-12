class_name Idle extends Movement

func get_name() -> String:
	return "Idle"

func _init():
	force_state = true
func move(ctx, out):
	super.move(ctx, out)
	out.direction.x = 0
func is_over(ctx) -> bool:
	return true
