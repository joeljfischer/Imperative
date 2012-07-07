package com.fande.botdefense {
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import com.fande.botdefense.Worlds.GameWorld;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class Main extends Engine {
		
		public function Main():void {
			super(640, 480, 60, false);
			//FP.screen.scale = 2;
			FP.console.enable();
		}
		
		override public function init():void {
			trace("Flashpunk has initialized");
			FP.world = new GameWorld();
			super.init();
		}
	}
}