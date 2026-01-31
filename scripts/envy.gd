class_name envy extends EnemyClass


@onready var animation_player: AnimatedSprite2D= $AnimatedSprite2D

var shoot_range = 500
var bullet_size = 100
var target_distance = 0
var traveled_distance = 0
@onready var attack = $Attack
func shoot(direction:Vector2):
	if state == State.Attacking:
		return
	set_state(State.Attacking)
	var ray :RayCast2D = $Attack/RayCast2D
	var collision = ray.get_collider()
	if not collision:
		target_distance = 500
	else:
		var vec = collision.position - attack.position
		target_distance = vec.x
	var line = Line2D.new()
	line.width = 2
	attack.add_child(line)
	line.add_point(Vector2(traveled_distance, 0))
	traveled_distance +=bullet_size
	if traveled_distance > target_distance:
		traveled_distance = target_distance
		line.add_point(Vector2(traveled_distance ))
		set_state(State.Chasing)
		
	

func _process(delta: float) -> void:
	flip_character()
	shoot(Vector2(1,0))
	





		
