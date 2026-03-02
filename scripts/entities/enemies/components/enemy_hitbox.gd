class_name  Hitbox extends Area2D

@onready var entity: Entity = $".."

func take_damage(amount):
	entity.take_damage(entity)


			
