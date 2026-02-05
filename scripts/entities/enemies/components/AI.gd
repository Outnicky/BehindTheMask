class_name EnemyAi extends RefCounted

var e :EnemyClass 
enum Actions {Wonder, Chase}
var action = Actions.Wonder
func _init(enemy):
	e = enemy
func wonder():
	e.state.move()
	#enemy.chanset_state(State.Wandering)
	var multipier = randf_range(0.5, 1)
	if !e.has_floor(e.ground_right):
		e.direction = -1 
	elif !e.has_floor(e.ground_left): 
		e.direction = 1
	else:
		e.direction = [-1, 1].pick_random()		
	e.velocity.x  = e.direction * e.SPEED 
	e.timer_walk.wait_time = e.get_walk_time()
	e.timer_walk.start()
	e.timer_walk.timeout.connect(wait)
func wait():
	e.state.idle()
	e.velocity = Vector2.ZERO
	e.timer_wait.wait_time =e.get_wait_time()
	e.timer_wait.start()
	e.timer_wait.timeout.connect( wonder)

func  look(dir: Vector2):
	var i = 0
	e.player_in_vision = false
	for ray: RayCast2D in e.node.get_children():
		var angle_rad = deg_to_rad(20  - i * 2)
		var vector = dir.rotated(angle_rad)
		var target = Vector2(vector.x, vector.y) * e.RAYCAST_DISTANCE 
		if ray.is_colliding():
			if ray.get_collider() is Player:
				pass
				#e.set_state(State.Chasing)
				#player_in_vision = true
		ray.target_position = target
		ray.position = Vector2.ZERO
		ray.force_raycast_update()
		i+=1
