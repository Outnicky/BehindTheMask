class_name  Attack extends Actions

var cooldown = 1
var dmg = 1

func _init():
	block_movement = true
	

func get_name() -> String:
	return "Attack"

func get_audio_name()-> String:
	return "Swing"

func animate():
	super.animate()
	print("animating attack")
func start():
	super.start()
	entity.audio_manager.play(get_audio_name())
	entity.can_attack = false
	entity.get_tree().create_timer(cooldown).timeout.connect(func():
		if is_instance_valid(entity):
			entity.can_attack = true
		)

func update_physics( delta):
	super.update_physics(delta)
	for body  in entity.attack_controller.get_overlapping_areas():
		if body is Hitbox:
			body.take_damage(1)
	for body  in entity.attack_controller.get_overlapping_bodies():
		body.take_damage(entity)
			


func can_swap_into():
	return entity.can_attack

func update(delta):
	super.update(delta)
	print("attacking")
	
