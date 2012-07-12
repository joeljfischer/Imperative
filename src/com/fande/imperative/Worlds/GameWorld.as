package com.fande.imperative.Worlds 
{
	import com.fande.imperative.Entities.Enemies.Enemy;
	import com.fande.imperative.Entities.Player;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import com.fande.imperative.Entities.Level.Level;
	import com.fande.imperative.Assets.Gfx.TileMaps;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class GameWorld extends BaseWorld
	{
		private var _level:Level;
		//private var square:Entity;
		
		public function GameWorld() 
		{
			trace("GameWorld Constructor");
		}
		
		override public function begin():void {
			_level = Level(add(new Level(TileMaps.XML_LEVEL)));
			add(new Player(level.getPlayerStart(), level.gridSize));
			super.begin();
		}
		
		override public function update():void {
			super.update();
		}
		
		public function get level():Level {
			return _level;
		}
		
	}

}