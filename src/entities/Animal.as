package entities 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Raimonds Zarins
	 */
	public class Animal
	{
		
		public var age:uint = 1;
		private var ticksGone:uint = 0;
		//public var isOnScreen:Boolean = false;
		public var graphic:FlxSprite;
		public var x:Number;
		public var y:Number;
		public var animal:Class;
		public var isFed:Boolean = true;
		public function Animal(animalGFX:Class, x:Number, y:Number) 
		{
			//super(x, y, animalGFX);
			this.x = x;
			this.y = y;
			animal = animalGFX;
		}

		
		public function setGraphic():void
		{
			graphic = new FlxSprite(x, y, animal);
		}
		
	}

}