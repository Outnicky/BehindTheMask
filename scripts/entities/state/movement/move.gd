class_name  Move extends Movement


func update_from_state(other):
	dir = other.dir
	

func _init(_dir):
	dir =  _dir

func get_name() -> String:
	return "Walk"
