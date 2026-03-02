class_name EnemyController extends StateMachine

func update_physics(ctx: Context, out: PhysicsOutput):
	super.update_physics(ctx, out)
	new_command( Attack.new())
