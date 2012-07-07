package com.fande.imperative.Entities.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Enemy extends Entity {
		
		[Embed(source = "../../../../../../img/Image1.png")] public const ENEMY_GRAPHIC:Class;
		
		public function Enemy() {
			this.graphic = new Image(ENEMY_GRAPHIC);
			this.x = FP.rand(FP.screen.width);
			this.y = FP.rand(FP.screen.height);
			type = "enemy";
			setHitbox(32, 32);
		}
	}
}