class_name PlayerNormal extends PrimaryState


var temporary_velocity :Vector2
var running = false
var crouching = false


var left = false
var right = false

func _init(e):
	super._init(e)
	

#var movements = {
#	"Move" : Move.new(),
#	"Idle": Idle.new()
#}
#var actions ={
##	"Junp" : PlayerJump.new(),
#	"Dash" : Dash.new(),
#	"Attack" : Attack.new(),
#	"Damaged": Damaged.new()
#}
#func get_movement(name) -> State:
	#return movements.get(name)


	
func handle_input(event: InputEvent):
	if event.is_action_pressed("left"):
		left = true
		movememtSM.new_state(Move.new(Vector2(-1,0)))
		#movememtSM.new_state(movements.get("Move").setup(Vector2(-1,0)))
	elif event.is_action_pressed("right"):
		right = true
		#get("Move").setup()
		#movememtSM.new_state(movements.get("Move").setup(Vector2(-1,0)))
		movememtSM.new_state(Move.new(Vector2(1,0)))
	if event.is_action_released("right") :
		right = false
		if !right and !left:
			movememtSM.new_state(Idle.new())
		else:
			movememtSM.new_state(Move.new(Vector2(-1,0)))
	elif event.is_action_released("left"):
		left = false
		if !right and !left:
			movememtSM.new_state(Idle.new())
		else:
			movememtSM.new_state(Move.new(Vector2(1,0)))
	elif event.is_action_pressed("jump"):
		actionsSM.new_state(PlayerJump.new())
	elif event.is_action_pressed("dash"):
		actionsSM.new_state(Dash.new())
	elif event.is_action_pressed("crouch"):
		crouching = true
	#elif ($RayCast2D.is_colliding() == false and $RayCast2D2.is_colliding() == false and is_on_floor()):
#		sm.new_state(Dash.new())
	elif event.is_action_pressed("attack"):
		#if state.handle_input(Input) == state.Result.PASS:
		actionsSM.new_state(Attack.new())


func on_actions_change():
	if actionsSM.state == null:
		movememtSM.animate()
	

func update_physics(delta):
	super.update_physics(delta)
	if crouching:
		entity.velocity *= entity.CROUCHING_MULTIPLIER 
	elif running:
		entity.velocity *= entity.RUN_MODIFIER 
		
