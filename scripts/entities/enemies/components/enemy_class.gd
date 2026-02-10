class_name EnemyClass extends Entity



const FOV = 5
const RAYCAST_AMOUNT = 40
const RAYCAST_DISTANCE = 500
const SPEED =300
const ray = preload("res://scenes/ray.tscn")
var node : Node2D 

const wait_decrease = 3
var wait_time
var wander_time = 300
const wonder_decrease = 8


var timer_wait : Timer
var timer_walk : Timer
var timer_lose_sight: Timer
var block_animation= false

var player_in_vision = false
@onready var player = $"%Player"
@onready var ground_left: Area2D =$ground_left
@onready var ground_right  : Area2D = $ground_right
var ai: EnemyAi = EnemyAi.new(self)

func get_ray():
	var ray = ray.instantiate()
	return ray

func ready():
	max_hp = 5




	
func take_damage(entity):
	set_health( current_hp -1)

		
func show_raycast_line(target):
	var line = Line2D.new()
	node.add_child(line)	
	line.width =1		
	line.add_point(Vector2.ZERO)
	line.add_point(target)
	line.visible =  true
		


func get_wait_time():
	return  randi_range(0.2, 0.5)
func get_walk_time():
	return  randi_range(0.3, 0.7)

func has_floor(obj: Area2D)-> bool:
	return obj.has_overlapping_bodies()
	#return !obj.get_overlapping_bodies().size()==0
	
	


func _ready() -> void:
	super._ready()
	timer_wait  =  Timer.new()
	timer_wait.one_shot = true
	timer_wait.wait_time = get_wait_time()
	timer_walk = Timer.new()
	timer_walk.one_shot = true
	timer_walk.wait_time = get_walk_time()
	timer_lose_sight = Timer.new()
	timer_lose_sight.one_shot = true
	timer_lose_sight.wait_time = 1
	add_child(timer_wait)
	add_child(timer_walk)
	add_child(timer_lose_sight)
	timer_lose_sight.timeout.connect(func():
		ai.wait()
	)
	node = Node2D.new()
	add_child(node)
	node.position = Vector2.ZERO
	for i in range(RAYCAST_AMOUNT):
		node.add_child(get_ray())
		pass
	pass
	ai.wonder()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if ai.action == ai.Actions.Chase:
		var vector =   player.position - position
		ai.look(vector.normalized()) 
		if player_in_vision == false:		
			velocity.x = 0
		else:
			timer_lose_sight.start()
			var dir = 1
			if vector.x < 0:
				dir = -1
			velocity.x = dir * SPEED
	else:
		ai.look(Vector2(direction, velocity.y).normalized())
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	if velocity.x > 0:
		if !has_floor(ground_right):
			velocity.x = 0
	if velocity.x < 0:
		if !has_floor(ground_left):
			velocity.x = 0
	if attack_controller.has_overlapping_bodies():
		state_machine.set_new_state(Attack.new(self))
	move_and_slide()

func flip_character():
	var a = direction
	if a == -1:
		a = 0
	$AnimationController.flip_h  = a
