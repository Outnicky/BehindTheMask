class_name EnemyState extends PrimaryState

func update_physics(ctx: Context, out: PhysicsOutput):
	super.update_physics(ctx, out)
	new_state(ctx, Attack.new())
