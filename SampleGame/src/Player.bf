using System;

namespace Strawberry.Sample
{
	public class Player	: Component, IUpdate, IDraw
	{
		static public Entity Create(Point pos)
		{
			let e = new Entity(pos);

			e.Add(new Player());
			let hitbox = e.Add(new Hitbox(-4, -8, 16, 16));
			e.Add(new Physics(hitbox));

			return e;
		}

		public Vector Speed;

		private Physics physics;
		private Timer tJumpGrace;
		private Timer tVarJump;

		public override void Added()
		{
			base.Added();

			tJumpGrace = Entity.Add(new Timer());
			tVarJump = Entity.Add(new Timer());
		}

		public override void Awake()
		{
			physics = Entity.First<Physics>();
		}

		public void Update()
		{
			const float coyoteTime = 0.1f;		// Time after leaving a ledge when you can still jump
			const float varJumpTime = 0.2f;		// Time after jumping that you can hold the jump button to continue gaining upward speed
			const float jumpSpeed = -160;
			const float jumpXBoost = 30;		// If left or right is held at the moment of a jump, this horizontal speed boost is applied
			const float maxFall = 160;
			const float gravity = 1000;
			const float halfGravThreshold = 40;	// Halves gravity at the peak of a jump, if the jump button is held
			const float maxRun = 100;
			const float runAccel = 800;
			const float runAccelAirMult = 0.8f;	// Gives you slightly less control of horizontal motion in the air

			let onGround = physics.GroundCheck();
			if (onGround)
				tJumpGrace.Value = coyoteTime;

			//Vertical Control
			{
				//Jumping
				if (tJumpGrace && Controls.Jump.Pressed)
				{
					Controls.Jump.ClearPressBuffer();
					tJumpGrace.Clear();
					tVarJump.Value = varJumpTime;
					Speed.Y = jumpSpeed;
					Speed.X += jumpXBoost * Controls.MoveX.Valuei;
				}
				else
				{
					//Gravity
					{
						float mult;
						if (Controls.Jump.Check && Math.Abs(Speed.Y) <= halfGravThreshold)
							mult = 0.5f;
						else
							mult = 1;
		
						Speed.Y = Calc.Approach(Speed.Y, maxFall, gravity * mult * Time.Delta);
					}
	
					//Variable Jumping
					if (tVarJump)
					{
						if (Controls.Jump.Check)
							Speed.Y = jumpSpeed;
						else
							tVarJump.Clear();
					}
				}
			}

			//Horizontal Control
			{
				float accel = runAccel;
				if (!onGround)
					accel *= runAccelAirMult; 

				Speed.X = Calc.Approach(Speed.X, Controls.MoveX.Valuei * maxRun, accel * Time.Delta);
			}
			
			//Resolve Speed
			physics.MoveX(Speed.X * Time.Delta, scope => OnCollideX);
			physics.MoveY(Speed.Y * Time.Delta, scope => OnCollideY);
		}

		private void OnCollideX(Collision col)
		{
			Speed.X = 0;
			physics.ZeroRemainderX();
		}

		private void OnCollideY(Collision col)
		{
			Speed.Y = 0;
			physics.ZeroRemainderY();
		}

		public void Draw()
		{
			physics.Hitbox.DebugDraw();
		}
	}
}
