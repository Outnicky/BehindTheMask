class_name  Move extends Movement


func update_from_state(other):
	if other == self:
		dir = other.dir
	

func _init(_dir):
	dir =  _dir

func move(delta):
	var s=  entity.SPEED
	entity.apply_gravity(delta)
	entity.velocity.x = dir.x  * entity.SPEED
	entity.set_direction(dir.x)
func get_name() -> String:
	return "Walk"

func start():
	super.start()



func is_over() -> bool:
	return false
	
