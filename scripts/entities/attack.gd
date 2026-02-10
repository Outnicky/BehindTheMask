class_name MeleeAttack extends Area2D

func _physics_process(delta: float) -> void:
	var animation = $"../AnimatedSprite2D"
	var s = $".."
	var c = get_child(0) 
	if s.velocity.x < 0:
		animation.flip_h = true
		if  c.position.x >0:
			for body in get_children():
				body.position.x *=-1
	if s.velocity.x > 0:
		animation.flip_h = false
		if  c.position.x <0:
			for body in get_children():
				body.position.x *=-1


	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var s = $".."
		$"..".set_state(s.State.Attacking)
		body.take_damage($"..")
	pass # Replace with function body.
