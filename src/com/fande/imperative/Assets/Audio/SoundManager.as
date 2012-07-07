package com.fande.imperative.Assets.Audio 
{
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Joel Fischer
	 */
	public class SoundManager {
		
		private static var MUSIC_VOLUME = 10;
		private static var SFX_VOLUME = 10;
		
		private static var currentMusic:Sfx;
		
		public function SoundManager() {
			
		}
		
		public static function get currentMusic():Sfx {
			return currentMusic;
		}
		
		public static function set currentMusic(music:Sfx):void 
		{
			
		}
		
		public static function playSound(name:String, type:String, pan:Number:0, callback:Function:null):void 
		{
			var sound:Sfx = new Sfx(this[name.toUpperCase()], callback, type);
			sound.play(SFX_VOLUME / 10, pan);
		}
		
	}

}