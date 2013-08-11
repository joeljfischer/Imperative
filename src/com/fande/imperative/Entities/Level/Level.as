package com.fande.imperative.Entities.Level 
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.FP;
	import com.fande.imperative.Assets.Gfx.TileMaps;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Level extends Entity 
	{
		public var xmlData:XML;
		
		private var tiles:Tilemap;
		private var grid:Grid;
		
		private var _levelName:String;
		private var _tileSize:uint;
		private var _gridSize:uint;
		
		public function Level(xml:Class) 
		{
			xmlData = FP.getXML(xml);
			
			_levelName = String(xmlData.@levelname);
			width = int(xmlData.@width);
			height = int(xmlData.@height);
			_tileSize = int(xmlData.@tilesize);
			_gridSize = int(xmlData.@gridsize);
			
			tiles = new Tilemap(TileMaps.TEMP_TILEMAPS, width, height, _tileSize, _tileSize);
			graphic = tiles;
			layer = 1;
			
			grid = new Grid(width, height, _gridSize, _gridSize);
			mask = grid;
			
			type = "level";
			
			loadLevel(xml);
		}
		
		public function getPlayerStart():Point {
			var dataList:XMLList = xmlData.EntityLayer.PlayerShip;
			var dataElement:XML;
			var point:Point;
			
			for each(dataElement in dataList) {
				point = new Point(int(dataElement.@x), int(dataElement.@y));
			}
			
			return point;
		}
		
		public function getEnemyShips():Array {
			var dataList:XMLList = xmlData.EntityLayer.EnemyShip;
			var dataElement:XML;
			var enemyArray:Array;
			
			for each(dataElement in dataList) {
				enemyArray.push(new Point(dataElement.@x, dataElement.@y));
			}
			
			return enemyArray;
		}
		
		private function loadLevel(xml:Class):void {
			var dataList:XMLList = xmlData.TileLayer.tile;
			var dataElement:XML;
			
			for each(dataElement in dataList) {
				tiles.setTile(int(dataElement.@x), int(dataElement.@y), int(dataElement.@id));
			}
			
			dataList = xmlData.GridLayer.rect;
			
			for each(dataElement in dataList) {
				grid.setRect(int(dataElement.@x / gridSize), int(dataElement.@y / gridSize), int(dataElement.@w / gridSize), int(dataElement.@h / gridSize), true);
			}
		}
		
		public function get levelName():String {
			return _levelName;
		}
		
		public function get tileSize():uint {
			return _tileSize;
		}
		
		public function get gridSize():uint {
			return _gridSize;
		}
	}
}