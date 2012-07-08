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
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Player extends Entity 
	{
		[Embed(source = "../../../../../img/player.png")] private const PLAYER_GRAPHIC:Class;
		
		public var image:Image;
		
		private var _velocity:Point;
		private var gridSize:uint;
		
		public function Player(start:Point, gridSize:uint) 
		{
			this.x = start.x;
			this.y = start.y;
			
			_velocity = new Point();
			
			image = new Image(PLAYER_GRAPHIC);
			this.graphic = image;
			
			setHitbox(image.width, image.height);
			type = "player";
			
			this.gridSize = gridSize;
		}
		
		override public function update():void {
			updateMovement();
			updateCollision();
			
			super.update();
		}
		
		private function updateMovement():void {
			var movement:Point = new Point();
			
			if (Input.check(Key.UP)) movement.y--;
			if (Input.check(Key.DOWN)) movement.y++;
			if (Input.check(Key.LEFT)) movement.x--;
			if (Input.check(Key.RIGHT)) movement.x++;
			
			_velocity.x = 100 * FP.elapsed * movement.x;
			_velocity.y = 100 * FP.elapsed * movement.y;
		}
		
		private function updateCollision():void {
			x += _velocity.x;
			
			if (collide("level", x, y)) {
				//Moving right
				if (FP.sign(_velocity.x) > 0) {
					_velocity.x = 0;
					x = Math.floor(x / gridSize) * gridSize + gridSize - width;
					
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
					y = Math.floor(y / gridSize) * gridSize + gridSize - height;
					
				} else { //Moving up
					_velocity.y = 0;
					y = Math.floor(y / gridSize) * gridSize + gridSize;
				}
			}
			
		}
	}
}