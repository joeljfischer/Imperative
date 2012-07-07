package com.fande.imperative.Entities.Level 
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Level extends Entity 
	{
		[Embed(source = "../../../../../../img/tileset/floortiles.png")] private const EXAMPLE_TILESET:Class;
		
		public var xmlData:XML;
		
		private var tiles:Tilemap;
		private var grid:Grid;
		
		public function Level(xml:Class) 
		{
			tiles = new Tilemap(EXAMPLE_TILESET, 640, 480, 32, 32);
			graphic = tiles;
			layer = 1;
			
			grid = new Grid(640, 480, 32, 32, 0, 0);
			mask = grid;
			
			type = "level";
			
			loadLevel(xml);
		}
		
		public function getPlayerStart():Point {
			var dataList:XMLList = xmlData.EntityLayer.PlayerShip;
			var dataElement:XML;
			
			for each(dataElement in dataList) {
				return new Point(int(dataElement.@x), int(dataElement.@y));
			}
			return null;
		}
		
		private function loadLevel(xml:Class):void {
			var rawData:ByteArray = new xml();
			var dataString:String = rawData.readUTFBytes(rawData.length);
			xmlData = new XML(dataString);
			
			var dataList:XMLList = xmlData.TileLayer.tile;
			var dataElement:XML;
			
			for each(dataElement in dataList) {
				tiles.setTile(int(dataElement.@x), int(dataElement.@y), int(dataElement.@id));
				grid.setTile(int(dataElement.@x), int(dataElement.@y), int(dataElement.@id) == 10);
			}
		}
	}
}