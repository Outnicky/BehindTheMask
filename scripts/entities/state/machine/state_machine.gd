class_name StateMachine

var movement: State  = Idle.new()
var action: State = Nothing.new()

var move_dir = Vector2.ZERO
var animation_normal : VisualOutput.AnimationData
var animation_overlay: VisualOutput.AnimationData

var new_commands = []
var ctx: Context

func generate_context(entity: Entity, delta) -> Context:
	ctx = Context.new(entity, delta)
	ctx.move_direction = move_dir
	ctx.direction_x = entity.facing_direction
	return ctx

func new_command(state):
	new_commands.append(state)

func stop_animation(ctx: Context):
	if !animation_normal:
		return
	if ctx.owner.animation_player.animation_finished.has_connections():
		ctx.owner.animation_player.animation_finished.disconnect(_on_animation_finish)

func resolve_animation(ctx: Context, out: VisualOutput):
	if !animation_normal:
		animation_normal = out.animation_normal
	elif out.animation_normal.priority > animation_normal.priority:
		stop_animation(ctx)
		animation_normal = out.animation_normal
	elif animation_normal.priority == out.animation_normal.priority and animation_normal.state != out.animation_normal.state:
		stop_animation(ctx)
		animation_normal = out.animation_normal
	if !animation_overlay:
		animation_overlay = out.animation_overlay

	if !animation_normal.started:
		animation_normal.started = true
		ctx.owner.animation_player.play(animation_normal.state.get_name())
		ctx.owner.animation_player.animation_finished.connect(_on_animation_finish)
func handle_command(ctx, state):
	if state is Movement:
		var response = movement.new_state(ctx, state)
		if response:
			movement = response
	if state is Actions:
		var response = action.new_state(ctx, state)
		if response:
			action = response
	pass
	
func _on_animation_finish():
	if animation_normal.on_finish:
		animation_normal.on_finish.call()
	animation_normal.priority = 0


func update_current_states(ctx):
	if action is not Nothing and  action.is_over(ctx):
		action = action.replace(ctx, Nothing.new())
	pass




func update_process(ctx: Context, out: VisualOutput):
	for state in new_commands:
		handle_command(ctx, state)
	new_commands.clear()
	update_current_states(ctx)
	movement.update_process(ctx, out)
	action.update_process(ctx, out)
	if action.is_over(ctx) and action is not Nothing:
		action.new_state(ctx, Nothing.new())
		animation_normal.priority = 0
	

func update_physics(ctx: Context, out: PhysicsOutput):
	movement.update_physics(ctx, out)
	action.update_physics(ctx, out)
	move_dir = out.direction.normalized()
