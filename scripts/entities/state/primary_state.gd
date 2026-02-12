class_name PrimaryState extends State

var movememtSM: StateMachine 
var actionsSM: StateMachine

func _init(e):
	entity = e
	movememtSM = StateMachine.new(e, Idle.new())
	actionsSM = StateMachine.new(e, Nothing.new())

func new_state(state):
	if state is Movement:
		movememtSM.new_state(state)
	elif state is Actions:
		actionsSM.new_state(state)


func update(delta):
	movememtSM.update(delta)
	actionsSM.update(delta)
	movememtSM.blend_animation(actionsSM)
	if actionsSM.state.is_over() and actionsSM.state is not Nothing:
		actionsSM.stop()
		actionsSM.set_state(Nothing.new())
		movememtSM.animate()
	else:
		actionsSM.animate()
func update_physics(ctx: Context, out: MovementOutput):
	if !actionsSM.is_blocking_movement():
		movememtSM.update_physics( delta)
	actionsSM.update_physics(delta)
	
	pass
