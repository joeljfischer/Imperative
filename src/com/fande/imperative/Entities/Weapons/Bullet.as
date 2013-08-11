package com.fande.imperative.Entities.Weapons {
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Bullet extends Entity {
		
		//Pixels per second
		private static const BULLET_ACCELERATION:int = 4000;
		private static const BULLET_MAX_SPEED:int = 600;
		
		private var image:Image;
		private var velocity:Point;
		private var acceleration:Point;
		
		public function Bullet(startPosition:Point, startAngle:Number) {
			x = startPosition.x;
			y = startPosition.y;
		}
		
		override public function update():void {
			
		}
		
	}

}