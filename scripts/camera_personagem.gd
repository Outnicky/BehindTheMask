extends Camera2D


@onready var player = $"../Player"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	position = player.position
	pass
