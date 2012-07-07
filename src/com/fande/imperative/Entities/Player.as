package com.fande.imperative.Entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Player extends Entity 
	{
		[Embed(source = "../../../../../img/player.png")] private const PLAYER_GRAPHIC:Class;
		
		public var image:Image;
		private var _v:Point;
		
		public function Player(p:Point) 
		{
			this.x = p.x;
			this.y = p.y;
			
			_v = new Point();
			
			image = new Image(PLAYER_GRAPHIC);
			this.graphic = image;
			
			setHitbox(16, 16);
			type = "player";
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
			
			_v.x = 100 * FP.elapsed * movement.x;
			_v.y = 100 * FP.elapsed * movement.y;
		}
		
		private function updateCollision():void {
			x += _v.x;
			y += _v.y;
			
			if (this.collide("level", x, y)) {
				trace("collision");
			}
		}
	}
}