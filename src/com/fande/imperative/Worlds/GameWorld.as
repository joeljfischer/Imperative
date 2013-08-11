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
		private var _player:Player;
		
		private static var _levelSize:Point;
		private static var _gridSize:uint;
		
		public function GameWorld() {
			trace("GameWorld Constructor");
		}
		
		override public function begin():void {
			_level = Level(add(new Level(TileMaps.XML_LEVEL)));
			_levelSize = new Point(level.width, level.height);
			_gridSize = level.gridSize;
			
			_player = new Player(level.getPlayerStart());
			add(player);
			
			super.begin();
		}
		
		override public function update():void {
			super.update();
			
			// Camera follows the player, clamp the camera in the bounds of the game
			camera.x = player.x - FP.halfWidth;
			camera.y = player.y - FP.halfHeight;
			FP.clampInRect(camera, 0, 0, level.width - FP.width, level.height - FP.height);
		}
		
		public static function get levelSize():Point {
			return _levelSize;
		}
		
		public static function get gridSize():uint {
			return _gridSize;
		}
		
		public function get level():Level {
			return _level;
		}
		
		public function get player():Player {
			return _player;
		}
	}
}