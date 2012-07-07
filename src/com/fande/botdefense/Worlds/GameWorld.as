package com.fande.botdefense.Worlds 
{
	import com.fande.botdefense.Entities.Enemies.Enemy;
	import com.fande.botdefense.Entities.Player;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import com.fande.botdefense.Entities.Level.LevelTerrain;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class GameWorld extends BaseWorld
	{
		private var square:Entity;
		
		public function GameWorld() 
		{
			trace("GameWorld Constructor");
		}
		
		override public function begin():void {
			add(new Player(new Point(FP.screen.width/2, FP.screen.height/2)));
			add(new LevelTerrain());
			super.begin();
		}
		
		override public function update():void {
			
			super.update();
		}
		
	}

}