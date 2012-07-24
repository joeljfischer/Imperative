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
		
		public function GameWorld() {
			trace("GameWorld Constructor");
		}
		
		override public function begin():void {
			_level = Level(add(new Level(TileMaps.XML_LEVEL)));
			_player = new Player(level.getPlayerStart(), level.gridSize, new Point(level.width, level.height));
			add(player);
			
			super.begin();
		}
		
		override public function update():void {
			super.update();
			
			//Deal with the camera, follow the player
			camera.x = player.x - FP.halfWidth;
			camera.y = player.y - FP.halfHeight;
			FP.clampInRect(camera, 0, 0, level.width - FP.width, level.height - FP.height);
		}
		
		public function get level():Level {
			return _level;
		}
		
		public function get player():Player {
			return _player;
		}
	}
}