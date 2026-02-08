class_name  Move extends State

var SPEED =250.0


func move(delta):
	entity.velocity.x = dir.x  * SPEED
func get_name() -> String:
	return "Walk"

func setup(opts: Dictionary = {}) -> State:
	dir = opts["dir"]
	return self
func is_over() -> bool:
	return true
	
