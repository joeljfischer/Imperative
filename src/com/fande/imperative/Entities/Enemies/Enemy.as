package com.fande.imperative.Entities.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import com.fande.imperative.Assets.Gfx.Sprites;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Enemy extends Entity {
		
		public function Enemy() {
			this.graphic = new Image(Sprites.TEMP_ENEMY);
			this.x = FP.rand(FP.screen.width);
			this.y = FP.rand(FP.screen.height);
			type = "enemy";
			setHitbox(32, 32);
		}
	}
}