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
		public var image:Image;
		
		private var _velocity:Point;
		private var gridSize:uint;
		private var levelSize:Point;
		
		public function Player(start:Point, gridSize:uint, levelSize:Point)
		{
			this.x = start.x;
			this.y = start.y;
			this.levelSize = levelSize;
			
			_velocity = new Point();
			
			image = new Image(Sprites.PLAYER_IMAGE);
			this.graphic = image;
			
			setHitboxTo(image);
			type = "player";
			
			this.gridSize = gridSize;
		}
		
		override public function update():void {
			updateMovement();
			updateCollision();
			checkBounds();
			
			super.update();
		}
		
		private function updateMovement():void {
			var movement:Point = new Point();
			
			if (Input.check(Key.UP)) movement.y--;
			if (Input.check(Key.DOWN)) movement.y++;
			if (Input.check(Key.LEFT)) movement.x--;
			if (Input.check(Key.RIGHT)) movement.x++;
			trace(movement);
			
			_velocity.x = 180 * FP.elapsed * movement.x;
			_velocity.y = 180 * FP.elapsed * movement.y;
		}
		
		private function updateCollision():void {
			x += _velocity.x;
			
			if (collide("level", x, y)) {
				//Moving right
				if (FP.sign(_velocity.x) > 0) {
					_velocity.x = 0;
					x = Math.floor((x + width) / gridSize) * gridSize - width;
					
				} else { //Moving left
					_velocity.x = 0;
					x = Math.floor(x / gridSize) * gridSize + gridSize;
				}
			}
			
			
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
		
		private function checkBounds():void {
			FP.clampInRect(this, 0, 0, levelSize.x - width, levelSize.y - height);
		}
	}
}