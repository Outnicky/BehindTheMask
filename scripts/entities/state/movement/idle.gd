class_name Idle extends Movement

func get_name() -> String:
	return "Idle"


func move(delta):
	entity.velocity.x = 0
func is_over() -> bool:
	return true
