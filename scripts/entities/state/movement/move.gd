class_name  Move extends Movement


func update_from_state(other):
	if other is Move:	
		dir = other.dir
	

func _init(_dir):
	dir =  _dir
func update_process(ctx: Context, out: VisualOutput):
	super.update_process(ctx, out)
	
func get_name() -> String:
	return "Walk"
