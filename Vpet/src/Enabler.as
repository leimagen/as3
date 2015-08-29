package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Luiti
	 */
	public class Enabler
	{
		public function Enabler() {
			
		}
		
		public function activate(t:MovieClip) {
			var t:MovieClip = e.currentTarget as MovieClip;
			
			t.buttonMode = true;
			t.mouseChildren = false;
			
			t.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			t.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		private function outHandler(e:MouseEvent):void 
		{
			t.gotoAndPlay("out");
		}
		
		private function overHandler(e:MouseEvent):void 
		{
			t.gotoAndPlay("over");
		}
	}
	
}