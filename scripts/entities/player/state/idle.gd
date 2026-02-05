class_name  PlayerIdle extends PlayerState

func get_name() -> String:
	return "Idle"


func update(delta):
	player.apply_gravity(delta)
	player.velocity.x = 0

func start():
	super.start()

func is_over() -> bool:
	return true
