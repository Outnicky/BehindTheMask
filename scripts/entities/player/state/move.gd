class_name  PlayerMove extends PlayerState

const SPEED =250.0
const CROUCH_SPEED = 150.0
const CROUCH_DOWNARDS_VELOCITY = 550.0
var dir : Vector2

func get_name() -> String:
	return "Walk"


func is_over() -> bool:
	return true
	
func move():
	player.move()

func update(delta):
	super.update(delta)
