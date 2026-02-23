class_name EnemyEntity extends Entity


#const ray = preload("res://scenes/ray.tscn")
@onready var player = $"%PlayerEntity"
@onready var ground_left: Area2D =$ground_left
@onready var ground_right  : Area2D = $ground_right
var ai: EnemyAi = EnemyAi.new(self)

func _init() -> void:
	super._init()
	controller = EnemyController.new()

func has_floor(obj: Area2D)-> bool:
	return obj.has_overlapping_bodies()

func _ready() -> void:
	super._ready()
	ai.ready()
