class_name PlayerNormal extends PrimaryState


var temporary_velocity :Vector2
var running = false
var crouching = false


var left = false
var right = false



	
func handle_input(event: InputEvent):
	if event.is_action_pressed("left"):
		left = true
		new_states.append(Move.new(Vector2(-1,0)))
		#movememtSM.new_state(Move.new(Vector2(-1,0)))	
	elif event.is_action_pressed("right"):
		right = true
		new_states.append(Move.new(Vector2(1,0)))
		#movememtSM.new_state(Move.new(Vector2(1,0)))
	if event.is_action_released("right") :
		right = false
		if !right and !left:
			new_states.append(Idle.new())
			#movememtSM.new_state(Idle.new())
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
	if actionsSM.state is PlayerJump:
		pass
	if crouching:
		out.speed_multiplayer.x = ctx.out.CROUCHING_MULTIPLIER 
	elif running:
		out.speed_multiplayer.x  *= ctx.out.RUN_MODIFIER 
#	ctx.owner.velocity= out.direction* out.speed_multiplayer *out.speed + out.gravity
