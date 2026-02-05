class_name  EnemyHitbox extends Area2D

@onready var s = $".."

func take_damage(amount):
	s.health -= amount
	if s.health <= 0:
		s.queue_free()


			
