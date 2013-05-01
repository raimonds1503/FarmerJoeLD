package states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author Raimonds Zarins
	 */
	public class MenuState extends FlxState 
	{
		private var background:FlxSprite;
		public function MenuState() 
		{
			
		}
		
		override public function create():void 
		{
			super.create();
			background = new FlxSprite(0, 0, Assets.Menu);
			add(background);
		}
		
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.S)
			{
				FlxG.switchState(new GameState);
			}
		}
		
	}

}