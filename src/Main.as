package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxGame;
	import states.GameState;
	import states.MenuState;
	
	/**
	 * ...
	 * @author Raimonds Zarins
	 */
	public class Main extends FlxGame
	{
		
		public function Main():void 
		{
			super(800, 600, MenuState, 1, 60, 30, true);
		}
		
	}
	
}