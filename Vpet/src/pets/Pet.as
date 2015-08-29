package pets{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Main;
	
	public class Pet extends MovieClip {
		var burnMe:Timer = new Timer(1000, 0);
		public function Pet():void {
	
			
			
			burnMe.addEventListener(TimerEvent.TIMER, burnCalories);
			burnMe.start();
			
			trace("hello pet")
		}
		
		private function burnCalories(event:TimerEvent):void {	
			
			if (Main._newCalories == 0) {
				die();
				burnMe.stop();
			} else {
				Main._newCalories = Main._newCalories -= Main._burntCalories;
				displayCalories();
			}
		}
		
		private function displayCalories():void {
			Main._eatenCalories = 600;
			calories_mc.caloriesText_mc.calories_txt.text = Main._newCalories;
			calories_mc.gotoAndPlay("change");
		}
		
		private function die():void {
			gotoAndPlay("dead");
			
		}
		
	}
}