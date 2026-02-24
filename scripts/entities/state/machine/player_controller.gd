class_name PlayerController extends StateMachine


var temporary_velocity :Vector2
var running = false
var crouching = false


var left := false
var right := false




func generate_context(entity: Entity, delta) -> Context:
	ctx  = Context.new(entity, delta)
	ctx.move_direction = move_dir
	ctx.direction_x = entity.facing_direction
	return ctx

func handle_input(event: InputEvent):
	if event.is_action_pressed("left"):
		left = true
	elif event.is_action_pressed("right"):
		right = true
	if event.is_action_released("right") :
		right = false
	elif event.is_action_released("left"):
		left = false
	elif event.is_action_pressed("jump"):
		new_command(PlayerJump.new())
	elif event.is_action_pressed("dash"):
		new_command(Dash.new())
	elif event.is_action_pressed("crouch"):
		new_command(Crouch.new())
	elif event.is_action_pressed("attack"):
		new_command(Attack.new())


func update_current_states(ctx):
	super.update_current_states(ctx)
	if action is not Nothing:
		return
	if !movement.is_over(ctx):
		return
	
	if move_dir == Vector2.ZERO and ctx.owner.is_on_floor():
		movement = movement.replace(ctx, Idle.new())
	elif move_dir.y == 0:
		movement = movement.replace(ctx, Move.new())
	elif ctx.owner.velocity.y < 0 and movement.is_over(ctx)  :
		movement = movement.replace(ctx, Rise.new())
	else:
		movement = movement.replace(ctx, Fall.new())

func update_process(ctx: Context, out: VisualOutput):
	var r = 1 if right else 0
	var l = -1 if left and !right else 0 
	var x = r + l
	move_dir.x =  x
	super.update_process(ctx,out)
	
func update_physics(ctx : Context, out: PhysicsOutput):
	super.update_physics(ctx, out)
