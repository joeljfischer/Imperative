package com.fande.imperative.Entities.Weapons {
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	import com.fande.imperative.Entities.MovableEntity;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Bullet extends MovableEntity {
		
		//Pixels per second
		private static const BULLET_ACCELERATION:int = 4000;
		private static const BULLET_MAX_SPEED:int = 600;
		
		private var image:Image;
		private var velocity:Point;
		private var acceleration:Point;
		
		public function Bullet(startPosition:Point, startAngle:Point) {
			x = startPosition.x;
			y = startPosition.y;
			
			super(startPosition, 
		}
		
		override public function update():void {
			
		}
		
	}

}