/**
 * ...
 * @author Luiti
 */

package {

	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import fruits.Banana;
	import fruits.Cherry;
	import pets.Pet;
	import fruits.Fruit;
	import flash.events.Event;
	
	
	
	public class Main extends MovieClip {

		public static var _eatenCalories:int;
		public static var _burntCalories:uint = 100;
		public static var _newCalories:uint = 2000;
		
		private var banana_mc:MovieClip;
		private var cherry_mc:MovieClip;
		private var pet_mc:MovieClip;
		
		private var newName:String;
		private var randomFruitPoints:int;
		private var fruitTimer:Timer;
		private var petName:String;
		var ranint:int;
		
		public function Main():void {
			
			beginBtn.visible = false;
			splashTitle.visible = false;
			textField.visible = false;
			nameTitle.visible = false;
			dead_mc.visible = false;
			
			init();
		}
		
		private function init():void {
			
			
			
			trace("everything cool")
			
			//Show Splash Screen Elements
			splashIn();
			
		}
		
		private function splashIn(e:Event=null):void {
			
			beginBtn.visible = true;
			splashTitle.visible = true;
			textField.visible = true;
			
			beginBtn.alpha = 0;
			splashTitle.alpha = 0;
			textField.alpha = 0;
			
			TweenMax.to(splashTitle, 1, { alpha: 1 } );
			TweenMax.to(textField, 1, { delay:1, alpha: 1 } );
			TweenMax.to(beginBtn, 1, { delay:2, alpha: 1 } );
			
			enable(beginBtn);
		}
		
		private function splashOut():void {
			TweenMax.to(splashTitle, 1, { autoAlpha: 0 } );
			TweenMax.to(textField, 1, { autoAlpha: 0 } );
			TweenMax.to(beginBtn, 1, { autoAlpha: 0 } );
		}
		
		private function enable(t:MovieClip):void 
		{			
			t.buttonMode = true;
			t.mouseChildren = false;
			t.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			t.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
			t.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			newName = nameInput.text;
			petName = newName;
			nameInput.text = "";
		
			beginGame();
		}
		
		private function outHandler(e:MouseEvent):void 
		{
			e.currentTarget.gotoAndPlay("out");
		}
		
		private function overHandler(e:MouseEvent):void 
		{
			e.currentTarget.gotoAndPlay("over");
		}
		
		
		
		//************************// The Game Begins
		
		private function beginGame(e:Event=null):void {
			splashOut();
			
			nameTitle.visible = true;
			nameTitle.petName_txt.text = petName;
			nameTitle.alpha = 0;
			
			TweenMax.to(nameTitle, 1, { alpha: 1 } );
			
			fruitTimer = new Timer(4000, 0);
			
			fruitTimer.addEventListener(TimerEvent.TIMER, addFruit);
			
			addPet(newName);
			
			trace("The Pet is named "+ pet_mc.name)
			fruitTimer.start();
		}
		
		private function addFruit(e:TimerEvent):void 
		{
			ranint = Math.round(Math.random() * 9);

			
			if (ranint < 6) {
				addCherry();
				trace("cherry added!")
			}
			if (ranint > 5 && ranint < 10){
				addBanana();
				trace("banana added");
			}
			
			if(_newCalories == 0){
				endGame();
			}
		}

		private function addPet(petName:String):void 
		{
			pet_mc = new Pet();
			addChild(pet_mc);
			pet_mc.name = newName;
		}
		
		private function addCherry():void 
		{
			
			var randomX:uint = Math.floor(Math.random() * 500);
			cherry_mc = new Cherry();
			cherry_mc.x = randomX;
			cherry_mc.alpha = 0;
			
			addChild(cherry_mc);
			TweenMax.to(cherry_mc, 0.5, { alpha:1 });
			cherry_mc.addEventListener(MouseEvent.CLICK, performAction);
			cherry_mc.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			cherry_mc.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			
			TweenMax.to(cherry_mc, .5, { delay:3, autoAlpha:0 } );
			
		}
		
		private function addBanana():void 
		{
			
			var randomX:uint = Math.floor(Math.random() * 500);
			banana_mc = new Banana();
			
			banana_mc.x = randomX;
			trace(randomX);
			banana_mc.alpha = 0;
			addChild(banana_mc);
			TweenMax.to(banana_mc, 0.5, { alpha:1 });
			banana_mc.addEventListener(MouseEvent.CLICK, performAction);
			banana_mc.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			banana_mc.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			
			TweenMax.to(banana_mc, .5, { delay:3, autoAlpha:0 } );
			
		}
		
		private function performAction(e:MouseEvent):void 
		{
			
			var t:MovieClip = e.currentTarget as MovieClip;
			
			t.gotoAndPlay("clicked");
			t.points_mc.plusito.text = _eatenCalories;
			t.buttonMode = false;
			t.removeEventListener(MouseEvent.MOUSE_OUT, rollOut);
			t.removeEventListener(MouseEvent.MOUSE_OVER, rollOver);
			t.removeEventListener(MouseEvent.CLICK, performAction);
			eat();
			
			TweenMax.to(t, 1, { autoAlpha:0, delay:.5 });
		}
		
		private function rollOut(e:MouseEvent):void 
		{
			var t:MovieClip = e.currentTarget as MovieClip;
			t.gotoAndPlay("out");
		}
		
		private function rollOver(e:MouseEvent):void 
		{
			var t:MovieClip = e.currentTarget as MovieClip;
			t.gotoAndPlay("over");
		}
		private function eat():void {
			_newCalories = _newCalories += _eatenCalories;	
			
		}
		
		private function endGame():void {
			
			TweenMax.to(nameTitle, 1, { autoAlpha:0 } );
			fruitTimer.stop();
			
			dead_mc.visible = true;
			dead_mc.alpha = 0;
			
			dead_mc.petName_txt.text = newName;
			
			TweenMax.to(dead_mc, 1, { alpha:1 } );
			
		}
		
	}
	
}