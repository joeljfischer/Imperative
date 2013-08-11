package com.fande.imperative.Entities 
{
	import com.fande.imperative.Worlds.GameWorld;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import com.fande.imperative.Assets.Gfx.Sprites;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Player extends Entity 
	{
		private static const PLAYER_ACCELERATION:int = 360; //Pixels per second
		private static const PLAYER_DECELERATION:int = 360;
		private static const PLAYER_MAX_SPEED:uint = 300; //Pixels per second
		
		private var image:Image;
		
		private var facing:Point;
		private var velocity:Point;
		private var acceleration:Point;
		
		private var isBoosting:Boolean;
		private var isSliding:Boolean;
		
		private var isPrimaryFiring:Boolean;
		private var isSecondaryFiring:Boolean;
		
		private var actionActivated:Boolean;
		
		/**
		 * Object of a player character
		 * 
		 * @param	start		The point at which the player character starts
		 * @param	gridSize	The size of the grid squares
		 * @param	levelSize	The size of the level rectangle
		 */
		public function Player(start:Point) {
			//Pull in the player's initial X and Y positions
			this.x = start.x;
			this.y = start.y;
			
			//Create a movement attributes
			facing = new Point();
			velocity = new Point();
			acceleration = new Point();
			
			//Pull the player's graphic from the assets
			image = new Image(Sprites.PLAYER_IMAGE);
			this.graphic = image;
			
			//Define the Controls
			defineControls();
			
			//Set the player's hitbox and collision type
			setHitboxTo(image);
			type = "player";
		}
		
		override public function update():void {
			updateKeys();
			updateMovement();
			updateCollision();
			checkGameBounds();
			
			if (isPrimaryFiring) {
				//Activate the Primary Fire Weapon
			}
			
			if (isSecondaryFiring) {
				//Activate the Secondary Fire Weapon
			}
			
			if (actionActivated) {
				//Use a stored powerup...or something, haven't decided
			}
			
			super.update();
		}
		
		/**
		 * Define the movement keys that will be used for the player character
		 */
		private function defineControls():void {
			//UP, DOWN, LEFT, RIGHT Movement
			Input.define("Up", Key.W);
			Input.define("Down", Key.S);
			Input.define("Left", Key.A);
			Input.define("Right", Key.D);
			
			//Special Movment
			Input.define("Slide", Key.SPACE);
			Input.define("Boost", Key.SHIFT);
			
			//Action
			Input.define("Action", Key.E);
			
			//Fire Keys
			Input.define("Primary Fire", Key.J);
			Input.define("Secondary Fire", Key.K);
		}
		
		/**
		 * Check each of the defined keys for the player and set appropriate vars
		 */
		private function updateKeys():void {
			//Reset the facing direction
			facing.x = 0;
			facing.y = 0;
			
			//Movement Keys
			if (Input.check("Up")) facing.y--;
			if (Input.check("Down")) facing.y++;
			if (Input.check("Left")) facing.x--;
			if (Input.check("Right")) facing.x++;
			
			//Special Movement Keys
			if (Input.check("Boost")) {
				isBoosting = true;
			} else {
				isBoosting = false;
			}
			if (Input.check("Slide")) {
				isSliding = true;
			} else {
				isSliding = false;
			}
			
			//Firing Keys
			if (Input.check("Primary Fire")) {
				isPrimaryFiring = true;
			} else {
				isPrimaryFiring = false;
			}
			if (Input.check("Secondary Fire")) {
				isSecondaryFiring = true;
			} else {
				isSecondaryFiring = false;
			}
			
			//Action Key(s)
			if (Input.pressed("Action")) {
				actionActivated = true;
			} else {
				actionActivated = false;
			}
			
		}
		
		/**
		 * Update the movement of the player based on pressed keys, acceleration, and velocity
		 */
		private function updateMovement():void {
			//Get the current acceleration
			acceleration.x = PLAYER_ACCELERATION * facing.x * FP.elapsed;
			acceleration.y = PLAYER_ACCELERATION * facing.y * FP.elapsed;
			
			//If the player has released the Left/Right Keys
			if (facing.x == 0) {
				//And the Player is travelling in the x directions
				if (FP.sign(velocity.x) > 0) {
					//Decelerate the player towards 0 velocity
					velocity.x = FP.approach(velocity.x, 0, (PLAYER_DECELERATION * FP.elapsed));
				} else if (FP.sign(velocity.x) < 0) {
					velocity.x = FP.approach(velocity.x, 0, (PLAYER_DECELERATION * FP.elapsed));
				}
			} else { //Player is pressing the button
				//Accelerate the player in the X direction
				velocity.x += acceleration.x;
			}
			
			if (facing.y == 0) {
				if (FP.sign(velocity.y) > 0) {
					velocity.y = FP.approach(velocity.y, 0, (PLAYER_DECELERATION * FP.elapsed));
				} else if (FP.sign(velocity.y) < 0) {
					velocity.y = FP.approach(velocity.y, 0, (PLAYER_DECELERATION * FP.elapsed));
				}
			} else {
				velocity.y += acceleration.y;
			}
			
			//Keep the player's velocity clamped within the max speed
			velocity.x = FP.clamp(velocity.x, -PLAYER_MAX_SPEED, PLAYER_MAX_SPEED);
			velocity.y = FP.clamp(velocity.y, -PLAYER_MAX_SPEED, PLAYER_MAX_SPEED);
			
			if (isSliding) {
				
			}
			
			if (isBoosting && !isSliding) {
				
			}
		}
		
		/**
		 * Check the collision for the player character
		 */
		private function updateCollision():void {
			
			//X plane collision
			x += velocity.x * FP.elapsed;
			if (collide("level", x, y)) {
				//Moving right
				if (FP.sign(velocity.x) > 0) {
					//Stop the vehicle in that direction
					velocity.x = 0;
					acceleration.x = 0;
					//Move the ship back to inside the bounds
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
		
		private function checkGameBounds():void {
			FP.clampInRect(this, 0, 0, GameWorld.levelSize.x - width, GameWorld.levelSize.y - height);
		}
	}
}