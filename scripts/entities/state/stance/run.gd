class_name Run extends Stance

const RUN_SPEED = 500

func get_name()-> String:
	return "Run"

func move(ctx, out):
	out.speed.x = RUN_SPEED
