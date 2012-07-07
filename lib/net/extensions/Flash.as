package net.extensions 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.utils.Draw;

	/**
	 * 
	 * Make a Flash of light appear on the screen!
	 * 
	 * @author Rolpege
	 * 
	 */	
	public class Flash
	{
		/**
		 * @private 
		 */		
		protected var alpha:Number = 0;
		/**
		 * @private 
		 */		
		protected var alphaSubtract:Number = 0;

		/**
		 * @private 
		 */		
		protected var colour:uint = 0xFFFFFF;

		/**
		 * @private 
		 */		
		protected var buffer:Canvas = new Canvas(FP.width, FP.height);

		/**
		 *
		 * Make the flash appear and then fade out
		 *  
		 * @param colour Color of the flash
		 * @param duration The time the flash will take to fade out
		 * 
		 */		
		public function start(colour:uint = 0xFFFFFF, duration:Number = 0.5):void
		{
			stop();
			this.colour = colour;

			alpha = 1;
			alphaSubtract = 1/duration;
		}

		/**
		 *
		 * Make the flash appear 
		 * 
		 */		
		public function stop():void
		{
			alpha = 0;
		}

		/**
		 *
		 * Call this every frame. You could add it on Engine.update or World.update. 
		 * 
		 */	
		public function update():void
		{
			if(alpha > 0)
			{
				alpha -= alphaSubtract * FP.elapsed;
			}
		}

		/**
		 *
		 * Call this every frame when rendering. You could add it on Engine.render or World.render. 
		 * 
		 */	
		public function render():void
		{
			if(alpha > 0) 
			{
				buffer.fill(new Rectangle(0, 0, buffer.width, buffer.height), colour, alpha);
				buffer.render(FP.buffer, new Point, new Point);
			}
		}
	}
}