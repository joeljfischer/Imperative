package com.fande.imperative.Entities.Weapons {
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	import com.fande.imperative.Entities.MovableEntity;
	import com.fande.imperative.Assets.Gfx.Sprites;
	
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
			facing = new Point();
			maxAcceleration = BULLET_ACCELERATION;
			maxDeceleration = BULLET_ACCELERATION;
			maxSpeed = BULLET_MAX_SPEED;
			
			image = new Image(Sprites.PLAYER_BULLET);
			this.graphic = image;
			setHitboxTo(image);
			
			type = "playerBullet";
		}
		
		override public function update():void {
			super.update();
		}
	}
}