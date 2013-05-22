package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Kurinkitos
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function calcPoint( xp:int , yp:int ):void
		{
			//
			zr = 0; 
			zi = 0; //
			cr = left + xstepping * xp; 
			ci = bot + ystepping * yp;
			//
			zrsq = 0;
			zisq = 0;
			//
			for ( var a:int = 0 ; a < MAX_ITTERATIONS ; ++a )

			{
				// Do the fractal math
				zi = zr * zi * 2 + ci;
				zr = zrsq - zisq + cr;
				// Save the squered numbers, so we don't have to do the opperation again
				zrsq = zr * zr;
				zisq = zi * zi;
				//
				if ( zrsq + zisq > 4 ) // 
				{

					//
					var color:Number = a << 16 | a << 8 | a ;
					myFractalBitmapData.setPixel( xp , yp , color );
					return;
					//
				}

				//
			}
			//
			myFractalBitmapData.setPixel( xp , yp , 0x000000 );
			//
		}
		private function zoom(aEventObj:TimerEvent):void
		{
			left += (xCenter - left) / 16;
			right += (xCenter - right) / 16;
			bot += (yCenter - bot) / 16;
			top += (yCenter - top) / 16;
			
			xstepping = (right - left) / WTH;
			ystepping = (top - bot) / HTH;
			
			//Generate the actual fractal
			for (var x:int = 0; x < WTH; x++)
			{
				for (var y:int = 0; y < HTH; y++)
				{
					calcPoint(x, y);
				}
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//Setup the bitmap, and fill it with black
			myFractalBitmapData = new BitmapData(WTH, HTH, false, 0x000000);
			myFractalBitmap = new Bitmap(myFractalBitmapData);
			addChild(myFractalBitmap);
			timer = new Timer(20);
			timer.addEventListener(TimerEvent.TIMER, zoom);
			timer.start();
		}
		
		private var myFractalBitmap:Bitmap;
		private var myFractalBitmapData:BitmapData;
		private var left:Number = -2; //Real axis min
		private var right:Number = 1; //Real axis max
		private var bot:Number = -1; //Imaginary axis min
		private var top:Number = 1; //Imaginary axis max
		private var xstepping:Number = ( right - left ) / WTH;
		private var ystepping:Number = ( top - bot ) / HTH;
		private var xCenter:Number = -0.743643887037151;
		private var yCenter:Number = 0.131825904205330;
		
		private var timer:Timer;
		
		//Vars for storing the temporary cords
		private var zr:Number;
		private var zi:Number; 
		private var cr:Number;
		private var ci:Number; 
		private var zrsq:Number;
		private var zisq:Number;
		
		private const WTH:int = 700; //Bitmap width
		private const HTH:int = 500; //Bitmap Height
		private const MAX_ITTERATIONS:int = 256; //Maximum numbers of cycels before bailout
		
	}
	
}