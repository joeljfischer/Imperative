package com.fande.imperative.Entities 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import com.fande.imperative.Worlds.GameWorld;
	
	/**
	 * ...
	 * @author ...
	 */
	internal class MovableEntity extends Entity
	{
		private var maxAcceleration:int;
		private var maxDeceleration:int;
		private var maxSpeed:int;
		
		private var facing:Point;
		private var velocity:Point;
		private var acceleration:Point;
		
		public function MovableEntity(start:Point, facing:Point, maxSpeed:int, maxAcceleration:int, maxDeceleration:int) {
			x = start.x;
			y = start.y;
			this.maxAcceleration = maxAcceleration;
			this.maxDeceleration = maxDeceleration;
			this.maxSpeed = maxSpeed;
			this.facing = facing;
			velocity = new Point();
			acceleration = new Point();
		}
		
		override public function update():void {
			updateMovement();
			updateCollision();
			clampInGameBounds();
		}
		
		/**
		 * Update the movement of the player based on pressed keys, acceleration, and velocity
		 */
		protected function updateMovement():void {
			//Get the current acceleration
			acceleration.x = maxAcceleration * facing.x * FP.elapsed;
			acceleration.y = maxAcceleration * facing.y * FP.elapsed;
			
			//If the player has released the Left/Right Keys
			if (facing.x == 0) {
				//And the Player is travelling in the x directions
				if (FP.sign(velocity.x) > 0) {
					//Decelerate the player towards 0 velocity
					velocity.x = FP.approach(velocity.x, 0, (maxDeceleration * FP.elapsed));
				} else if (FP.sign(velocity.x) < 0) {
					velocity.x = FP.approach(velocity.x, 0, (maxDeceleration * FP.elapsed));
				}
			} else { //Player is pressing the button
				//Accelerate the player in the X direction
				velocity.x += acceleration.x;
			}
			
			if (facing.y == 0) {
				if (FP.sign(velocity.y) > 0) {
					velocity.y = FP.approach(velocity.y, 0, (maxDeceleration * FP.elapsed));
				} else if (FP.sign(velocity.y) < 0) {
					velocity.y = FP.approach(velocity.y, 0, (maxDeceleration * FP.elapsed));
				}
			} else {
				velocity.y += acceleration.y;
			}
			
			//Keep the player's velocity clamped within the max speed
			velocity.x = FP.clamp(velocity.x, -maxSpeed, maxSpeed);
			velocity.y = FP.clamp(velocity.y, -maxSpeed, maxSpeed);
		}
		
		/**
		 * Check the collision for the player character
		 */
		protected function updateCollision():void {
			//X plane collision
			x += velocity.x * FP.elapsed;
			if (collide("level", x, y)) {
				//Moving right
				if (FP.sign(velocity.x) > 0) {
					//Stop the entity in that direction
					velocity.x = 0;
					acceleration.x = 0;
					//Move the entity back to inside the bounds
					x = Math.floor((x + width) / GameWorld.gridSize) * GameWorld.gridSize - width;
				} else { //Moving left
					velocity.x = 0;
					acceleration.x = 0;
					x = Math.floor(x / GameWorld.gridSize) * GameWorld.gridSize + GameWorld.gridSize;
				}
			}
			
			//Y plane collision
			y += velocity.y * FP.elapsed;
			if (collide("level", x, y)) {
				//Moving down
				if (FP.sign(velocity.y) > 0) {
					velocity.y = 0;
					acceleration.y = 0;
					y = Math.floor((y + height) / GameWorld.gridSize) * GameWorld.gridSize - height;
					
				} else { //Moving up
					velocity.y = 0;
					acceleration.y = 0;
					y = Math.floor(y / GameWorld.gridSize) * GameWorld.gridSize + GameWorld.gridSize;
				}
			}
		}
		
		protected function clampInGameBounds():void {
			FP.clampInRect(this, 0, 0, GameWorld.levelSize.x - this.width, GameWorld.levelSize.y - this.height);
		}
	}
}