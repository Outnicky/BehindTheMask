class_name  Damaged extends Actions


var vector :Vector2
var immunity_time=0.4
var elapsed = 0
var knockback_force = 900
var knockback_decelartion = 12
var current_knockback = 1
var other: Entity

func update(delta):
	super.update(delta)
	elapsed += delta

func move(delta) :
	entity.velocity.x = -500 * dir.x

func is_over() -> bool:
	return elapsed >= immunity_time
	
func setup(opts: Dictionary = {}) -> State:
	other = opts["other"]
	vector = other.position -  entity.position
	if vector.x > 0:
		dir.x = 1
	else:
		dir.x = -1
	return self

func get_name() -> String:
	return "Hurt"

func get_audio_name():
	return "Damage"
func start():
	super.start()
	var hp  = entity.current_hp - 1
	entity.set_health( entity.current_hp - 1)
	if entity.current_hp == 0:
		return
	entity.immune = true
	print("immune")
	entity.get_tree().create_timer(immunity_time).timeout.connect(func():
		entity.immune  = false
		print("no longer immune,", entity)
	)
	
