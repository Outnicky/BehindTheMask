class_name  PlayerAttack extends PlayerState


	
func get_name() -> String:
	return "Attack"


func start():
	super.start()
	for body in player.area.get_overlapping_areas():
		if body is EnemyHitbox:
				body.take_damage(1)
	player.audio_manager.play("Swing")

func move():
	if is_over():
		super.move()
	else:
		player.move()
func update(delta):
	super.update(delta)
