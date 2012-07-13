package com.fande.imperative.Entities.Weapons {
	import flash.geom.Point;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Bullet extends Entity {
		
		public function Bullet(startPosition:Point, startAngle:Number) {
			x = startPosition.x;
			y = startPosition.y;
		}
		
		override public function update():void {
			
		}
		
	}

}