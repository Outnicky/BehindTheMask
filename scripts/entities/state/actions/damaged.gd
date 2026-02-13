class_name  Damaged extends Actions


var vector :Vector2
var immunity_time=0.2
var knockback_force = 900
var knockback_decelartion = 12
var current_knockback = 1
var other: Entity

func _init(e):
	other = e



func move(ctx, out: PhysicsOutput): 
	out.velocity_multiplier.x = 0
	out.direction.x = -1
	out.speed.x = 500
	

func is_over(ctx) -> bool:
	return time_elapsed >= immunity_time
	

	

func get_name() -> String:
	return "Hurt"

func get_audio_name():
	return "Damage"
	
func start_process(ctx: Context, out: VisualOutput):
	super.start_process(ctx, out)
	var hp  = ctx.owner.current_hp - 1
	ctx.owner.set_health( ctx.owner.current_hp - 1)
	if ctx.owner.current_hp == 0:
		return
	ctx.owner.immune = true
	ctx.owner.get_tree().create_timer(immunity_time).timeout.connect(func():
		ctx.owner.immune  = false
	)
	pass
func start_physics(ctx: Context, out: PhysicsOutput):
	super.start_physics(ctx, out)
	vector = other.position -  ctx.owner.position
	if vector.x > 0:
		dir.x = 1
	else:
		dir.x = -1
	out.direction.x = dir.x
	
	
	
