class_name  Move extends Movement




func _init(_dir):
	dir =  _dir

func move(delta):
	var s=  entity.SPEED
	entity.velocity.x = dir.x  * entity.SPEED
	entity.set_direction(dir.x)
func get_name() -> String:
	return "Walk"

func start():
	super.start()



func is_over() -> bool:
	return true
	
