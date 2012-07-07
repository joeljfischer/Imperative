package net.extensions
{
	import net.flashpunk.FP;

	/**
	 * 
	 * Quake allows you to shake the whole screen on the game. Note that it doesn't use the camera, only shakes FP.screen.
	 * 
	 * @author Rolpege
	 */	
	public class Quake
	{
		/**
		 * @private
		 */		
		protected var intensity:Number=0;

		/**
		 * @private 
		 */		
		protected var timer:Number=0;

		/**
		 *
		 * Start quaking the screen!
		 *  
		 * @param intensity The amount of pixels the screen will be moved
		 * @param duration Time in seconds before the screen stops quaking
		 * 
		 */		
		public function start(intensity:Number=0.5, duration:Number=0.5):void
		{
			stop();
			this.intensity = intensity * 0.05;
			timer = duration;
		}

		/**
		 * 
		 * Immediatly stop quaking.
		 *  
		 */		
		public function stop():void
		{
			FP.screen.x = 0;
			FP.screen.y = 0;
			intensity = 0;
			timer = 0;
		}

		/**
		 *
		 * Call this every frame. You could add it on Engine.update or World.update. 
		 * 
		 */		
		public function update():void
		{
			if(timer > 0)
			{
				timer -= FP.elapsed;
				if(timer <= 0)
				{
					stop();
				}
				else
				{
					FP.screen.x = (Math.random()*intensity*FP.width*2-intensity*FP.width)*0.5;
					FP.screen.y = (Math.random()*intensity*FP.height*2-intensity*FP.height)*0.5;
				}
			}
		}
	}
}