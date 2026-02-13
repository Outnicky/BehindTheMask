class_name PrimaryState extends State

var movememtSM: StateMachine 
var actionsSM: StateMachine
var entity
var new_states= []

var animation_normal : VisualOutput.AnimationData
var animation_overlay: VisualOutput.AnimationData

func _init():
	movememtSM = StateMachine.new(Idle.new())
	actionsSM = StateMachine.new(Nothing.new())

func new_state(ctx, state):
	if state is Movement:
		movememtSM.new_state(ctx, state)
	elif state is Actions:
		actionsSM.new_state(ctx, state)

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

func _on_animation_finish( ):
	if animation_normal.on_finish:
		animation_normal.on_finish.call()
	animation_normal.priority = 0
	
func update_process(ctx: Context, out: VisualOutput):
	super.update_process(ctx,out)
	for state in new_states:
		new_state(ctx, state)
	new_states.clear()
	movememtSM.update_process(ctx, out)
	if actionsSM.state is Attack and actionsSM.state.is_over(ctx):
		pass
	if actionsSM.state.is_over(ctx):
		actionsSM.new_state(ctx, Nothing.new())
	else:
		actionsSM.update_process(ctx, out)
	resolve_animation(ctx,out)

func update_physics(ctx: Context, out: PhysicsOutput):
	super.update_physics(ctx, out)
	movememtSM.update_physics(ctx, out)
	actionsSM.update_physics(ctx, out)
