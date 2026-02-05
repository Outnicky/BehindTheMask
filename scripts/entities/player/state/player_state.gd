class_name PlayerState extends State

var player: Player

func _init(entity):
	super._init(entity)
	player = entity
	
func move():
	_swap(PlayerMove, PlayerMove.new(player).setup()  )
func jump():
	_swap(PlayerJump, PlayerJump.new(player).setup()  )
func idle():
	_swap(PlayerIdle, PlayerIdle.new(player).setup() )
func dash():
	_swap(PlayerDash, PlayerDash.new(player).setup())
	

func take_damage(enemy):
	pass
	#_swap(PlayerDamaged, PlayerDamaged.new(player).setup( {"enemy": enemy}) )


func attack():
	_swap(PlayerAttack, PlayerAttack.new(player) )
	





func change_if_over():
	if is_over() :
		if new_state:
			player.change_state(new_state as PlayerState)		

func is_over() -> bool:
	return animation_ended
func update(delta):
	player.apply_gravity(delta)
	pass
		
