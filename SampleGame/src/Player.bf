using System;

namespace Strawberry.Sample
{
	public class Player	: Actor
	{
		public Vector Speed;

		private Timer tJumpGrace;
		private Timer tVarJump;

		public this(Point pos)
			: base(pos)
		{
			Hitbox = Rect(-4, -8, 16, 16);

			Add(tJumpGrace = new Timer());
			Add(tVarJump = new Timer());
		}

		public override void Update()
		{
			base.Update();

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

			let onGround = GroundCheck();
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
			MoveX(Speed.X * Time.Delta, scope => OnCollideX);
			MoveY(Speed.Y * Time.Delta, scope => OnCollideY);
		}

		private void OnCollideX(Collision col)
		{
			Speed.X = 0;
			ZeroRemainderX();
		}

		private void OnCollideY(Collision col)
		{
			Speed.Y = 0;
			ZeroRemainderY();
		}

		public override void Draw()
		{
			base.Draw();

			DrawHitboxOutline(.Green);
			Game.Batcher.Tex(Assets.Textures["test"], X - 4, Y - 8);
		}
	}
}
