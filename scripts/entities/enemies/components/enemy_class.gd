class_name EnemyClass extends Entity



const FOV = 5
const RAYCAST_AMOUNT = 40
const RAYCAST_DISTANCE = 500
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

	


func has_floor(obj: Area2D)-> bool:
	return obj.has_overlapping_bodies()
	#return !obj.get_overlapping_bodies().size()==0
	
	


func _ready() -> void:
	super._ready()
	node = Node2D.new()
	add_child(node)
	node.position = Vector2.ZERO
	for i in range(RAYCAST_AMOUNT):
		node.add_child(ai.get_ray())
	ai.wonder()

func _process(delta: float) -> void:
	primary_state.new_state(Attack.new())

	primary_state.update(delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	primary_state.update_physics(delta)
	#ai.update(delta)
	#if attack_controller.has_overlapping_bodies():
	#	primary_state.new_state(Attack.new())
	#move_and_slide()
