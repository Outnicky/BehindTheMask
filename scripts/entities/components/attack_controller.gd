class_name AttackController extends Area2D

func get_collision():
	return $AttackHitbox
func flip():
	for body in get_children():
		body.position.x *=-1
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
