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
		private static const PLAYER_ACCELERATION:int = 120; //Pixels/Second
		private static const PLAYER_MAX_SPEED:uint = 200; //Pixels/Second
		
		private var image:Image;
		
		private var facing:Point;
		private var _velocity:Point;
		private var _acceleration:Point;
		
		private var gridSize:uint;
		private var levelSize:Point;
		
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
		public function Player(start:Point, gridSize:uint, levelSize:Point)
		{
			//Pull in the player's initial X and Y positions
			this.x = start.x;
			this.y = start.y;
			
			//Pull in the size of the current level and collision geometry, this is
			//needed for level bounds and collision, respectively
			this.levelSize = levelSize;
			this.gridSize = gridSize;
			
			//Create a movement attributes
			facing = new Point();
			_velocity = new Point();
			_acceleration = new Point();
			
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
			checkBounds();
			
			if (isPrimaryFiring) {
				//Activate the Primary Fire Weapon
				trace("Primary Weapon Firing");
			}
			
			if (isSecondaryFiring) {
				//Activate the Secondary Fire Weapon
				trace("Secondary Weapon Firing");
			}
			
			if (actionActivated) {
				//Locate a nearby object that you can use the action on
				trace("Action Trigger Firing");
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
			//Movement
			if (Input.check("Up")) facing.y--;
			if (Input.check("Down")) facing.y++;
			if (Input.check("Left")) facing.x--;
			if (Input.check("Right")) facing.x++;
			
			//Special Movement
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
			
			//Action
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
			_velocity.x = 180 * FP.elapsed * facing.x;
			_velocity.y = 180 * FP.elapsed * facing.y;
		}
		
		/**
		 * Check the collision for the player character
		 */
		private function updateCollision():void {
			
			//X plane collision
			x += _velocity.x;
			if (collide("level", x, y)) {
				//Moving right
				if (FP.sign(_velocity.x) > 0) {
					//Stop the vehicle in that direction
					_velocity.x = 0;
					//Move the ship back to inside the bounds
					x = Math.floor((x + width) / gridSize) * gridSize - width;
					
				} else { //Moving left
					_velocity.x = 0;
					x = Math.floor(x / gridSize) * gridSize + gridSize;
				}
			}
			
			//Y plane collision
			y += _velocity.y;
			if (collide("level", x, y)) {
				//Moving down
				if (FP.sign(_velocity.y) > 0) {
					_velocity.y = 0;
					y = Math.floor((y + height) / gridSize) * gridSize - height;
					
				} else { //Moving up
					_velocity.y = 0;
					y = Math.floor(y / gridSize) * gridSize + gridSize;
				}
			}
		}
		
		/**
		 * Check the player character against the bounds of the level
		 */
		private function checkBounds():void {
			//Clamp the ship inside the bounds of the level
			FP.clampInRect(this, 0, 0, levelSize.x - width, levelSize.y - height);
		}
	}
}