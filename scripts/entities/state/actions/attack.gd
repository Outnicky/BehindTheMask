class_name  Attack extends Actions

var cooldown = 1
var dmg = 1

	

func get_name() -> String:
	return "Attack"

func get_audio_name()-> String:
	return "Swing"



func start_process(ctx: Context, out: VisualOutput):
	super.start_process(ctx, out)
	ctx.owner.entity.can_attack = false
	ctx.owner.get_tree().create_timer(cooldown).timeout.connect(func():
		if is_instance_valid(ctx.owner):
			ctx.owner.can_attack = true
		)
	
func move(ctx: Context, out: PhysicsOutput):
	out.direction.x = 0
	
func update_physics(ctx: Context, out: PhysicsOutput):
	super.update_physics(ctx, out)
	for body  in ctx.owner.attack_controller.get_overlapping_areas():
		if body is Hitbox:
			body.take_damage(1)
	for body  in ctx.owner.attack_controller.get_overlapping_bodies():
		body.take_damage(ctx.owner)
			


func can_swap_into(ctx: Context):
	return ctx.owner.entity.can_attack
