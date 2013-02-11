package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
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
				//
				zi = zr * zi * 2 + ci;
				zr = zrsq - zisq + cr;
				//
				zrsq = zr * zr;
				zisq = zi * zi;
				//
				if ( zrsq + zisq > 4 ) // 
				{

					//
					var color:Number = a << 16 | (a + 50) << 8 | a ;
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
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//Setup the bitmap, and fill it with black
			myFractalBitmapData = new BitmapData(WTH, HTH, false, 0x000000);
			myFractalBitmap = new Bitmap(myFractalBitmapData);
			addChild(myFractalBitmap);
			//Generate the actual fractal
			for (var x:int = 0; x < WTH; x++)
			{
				for (var y:int = 0; y < HTH; y++)
				{
					calcPoint(x, y);
				}
			}
		}
		
		private var myFractalBitmap:Bitmap;
		private var myFractalBitmapData:BitmapData;
		private var left:Number = -2; //Real axis min
		private var right:Number = 1; //Real axis max
		private var bot:Number = -1; //Imaginary axis min
		private var top:Number = 1; //Imaginary axis max
		private var xstepping:Number = ( right - left ) / WTH;
		private var ystepping:Number = ( top - bot ) / HTH;
		
		//Vars for storing the temporary cords
		private var zr:Number;
		private var zi:Number; 
		private var cr:Number;
		private var ci:Number; 
		private var zrsq:Number;
		private var zisq:Number;
		
		private const WTH:int = 700; //Bitmap width
		private const HTH:int = 500; //Bitmap Height
		private const MAX_ITTERATIONS:int = 128; //Maximum numbers of cycels before bailout
		
	}
	
}