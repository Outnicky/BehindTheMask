class_name PlayerController extends StateMachine


var temporary_velocity :Vector2
var running = false
var crouching = false


var left = false
var right = false



func next_movement(ctx : Context, other: State)-> State:
	#if !movement.is_over(ctx):
		#return
	if action is not Nothing:
		return Idle.new()
	var e = ctx.owner
#	if !e.is_on_floor():
#		if e.velocity.y <0:
#			return Fall.new()
#		else:
#			if movement is PlayerJump and movement.is_over(ctx):
#				return Rise.new()
	var result = movement.new_state(ctx, other)
	return result
	#return Idle.new()

func next_action(ctx : Context, other: State)-> State:
	return
func handle_input(event: InputEvent):
	if event.is_action_pressed("left"):
		left = true
		new_states.append(Move.new(Vector2(-1,0)))
	elif event.is_action_pressed("right"):
		right = true
		new_states.append(Move.new(Vector2(1,0)))
	if event.is_action_released("right") :
		right = false
		if !right and !left:
			new_states.append(Idle.new())
		else:
			new_states.append(Move.new(Vector2(-1,0)))
	elif event.is_action_released("left"):
		left = false
		if !right and !left:
			new_states.append(Idle.new())
		else:
			new_states.append(Move.new(Vector2(1,0)))
	elif event.is_action_pressed("jump"):
		new_states.append(PlayerJump.new())
	elif event.is_action_pressed("dash"):
		new_states.append(Dash.new())
	elif event.is_action_pressed("crouch"):
		crouching = true
	#elif ($RayCast2D.is_colliding() == false and $RayCast2D2.is_colliding() == false and is_on_floor()):
#		sm.new_state(Dash.new())
	elif event.is_action_pressed("attack"):
		#if state.handle_input(Input) == state.Result.PASS:
		new_states.append(Attack.new())



func update_physics(ctx : Context, out: PhysicsOutput):
	super.update_physics(ctx, out)
	if crouching:
		out.speed_multiplayer.x = ctx.out.CROUCHING_MULTIPLIER 
	elif running:
		out.speed_multiplayer.x  *= ctx.out.RUN_MODIFIER 
