class_name EnemyAi extends Resource

var e :EnemyClass 
enum Actions {Wonder, Chase}
var action = Actions.Wonder
const ray = preload("res://scenes/ray.tscn")
var target : Entity
var last_sight_pos :Vector2
func _init(enemy):
	e = enemy

func get_ray():
	var ray = ray.instantiate()
	return ray


func get_wait_time():
	return  randi_range(2, 5)
func get_walk_time():
	return  randi_range(0.3, 0.7)

func get_forget_target_time():
	return  randi_range(3, 5)
func wonder():
	if action == Actions.Chase:
		return

	if !e.has_floor(e.ground_right):
		e.direction = -1 
	elif !e.has_floor(e.ground_left): 
		e.direction = 1
	else:
		e.direction = [-1, 1].pick_random()		
	e.primary_state.new_state(Move.new(Vector2(e.direction, 0)))
	e.velocity.x  = e.direction * e.SPEED 
	e.get_tree().create_timer(get_wait_time()).timeout.connect(wait)

func wait():
	if action == Actions.Chase:
		return
	e.primary_state.new_state(Idle.new())
	e.get_tree().create_timer(get_wait_time()).timeout.connect(wonder)

func chase():
	var vector =   target.position - e.position
	look(last_sight_pos) 
	var dir = 1
	if vector.x < 0:
		dir = -1
	e.primary_state.set_new_state(Move.new(Vector2(dir, 0)))
	#velocity.x = dir * SPEED
func  look(dir: Vector2):
	var i = 0
	var in_sight = false
	for ray: RayCast2D in e.node.get_children():
		var angle_rad = deg_to_rad(20  - i * 2)
		var vector = dir.rotated(angle_rad)
		var t = Vector2(vector.x, vector.y) * e.RAYCAST_DISTANCE 
		if ray.is_colliding():
			var obj = ray.get_collider()
			if obj is Player:
				target = obj
				last_sight_pos = target.position
				in_sight = false
		ray.target_position = t
		ray.position = Vector2.ZERO
		ray.force_raycast_update()
		i+=1
	if !in_sight:
		if target:
			e.get_tree().create_timer(get_wait_time()).timeout.connect(wonder)
		target = null

	
func update(delta):
	e.primary_state.new_state(Attack.new())
	for body in e.attack_controller.get_overlapping_bodies():
		print(body)
		if body is Player:
			print("PLAYER a")
			e.primary_state.new_state(Attack.new())
	if target:
		chase()
	elif last_sight_pos:
		look(last_sight_pos)
		e.state_machine.set_new_state(Idle.new())
