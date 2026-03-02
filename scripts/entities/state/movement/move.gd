class_name  Move extends Movement





func update_process(ctx: Context, out: VisualOutput):
	super.update_process(ctx, out)

func is_over(ctx) -> bool:
	return true
func get_name() -> String:
	return "Walk"
