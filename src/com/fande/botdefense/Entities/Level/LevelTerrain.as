package com.fande.botdefense.Entities.Level 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class LevelTerrain extends Entity 
	{
		[Embed(source="../../../../../../img/tileset/floortiles.png")] private const EXAMPLE_TILESET:Class;
		private var tiles:Tilemap;
		private var grid:Grid;
		
		public function LevelTerrain() 
		{
			tiles = new Tilemap(EXAMPLE_TILESET, 640, 480, 32, 32);
			graphic = tiles;
			layer = 1;
			
			tiles.setRect(0, 0, 640 / 32, 480 / 32, 0);
			tiles.setRect(3, 3, 3, 5, 3);
			tiles.setTile(12, 5, 3);
			
			grid = new Grid(640, 480, 32, 32, 0, 0);
			mask = grid;
			
			grid.setRect(3, 3, 3, 5, true);
			grid.setTile(12, 5, true);
			
			type = "level";
		}
	}
}