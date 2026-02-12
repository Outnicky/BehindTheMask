class_name Dash extends Actions

var dash_speed = 1300
var dashing := true
var dashing_timer = 0
var dashing_timeout = 0.2
var dash_cooldown = 1
var dash_direction = 1


#	dash_direction = e.direction
func get_name()-> String:
	return "Dash"
	
func move(ctx, out: PhysicsOutput):
	out.velocity.x = dash_speed
	out.direction.x = dir.x
func is_over(ctx) -> bool:
	return time_elapsed >= dashing_timeout

func stop(ctx):
	super.stop(ctx)
	ctx.owner.collision_mask = 3
	
func can_swap_into(ctx)-> bool:
	return ctx.owner.can_dash
func start_process(ctx, out: VisualOutput):
	super.start_process(ctx, out)
	var player = ctx.owner as Player
	player.can_dash = false
	player.collision_mask = 2
	player.get_tree().create_timer(dash_cooldown).timeout.connect(func():
		player.can_dash = true
		)
	
		

#func take_damage(enemy):
	#entity.audio_manager.play("perfect_dodge")
