package  
{
	import entities.Cow;
	import entities.Sheep;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Raimonds Zarins
	 */
	public class G 
	{
		public static var hours:uint = 18;
		public static var day:uint = 0;
		public static var sheeps:Array = [];
		public static var cows:Array = [];
		public static var coins:int = 500;
		public static var food:uint = 0;
		public static var timer:int = 0;
		public static var ticksHour:uint = G.TICSHOURDAY;
		public static var volves:FlxGroup;
		public static var volvesIndex:int = 0;
		public static var potatoes:FlxGroup;
		public static var potatoesIndex:int = 0;
		
		public static var typist:String = "";
		
		
		public static const TICSHOURDAY:uint = 4 * 60; //secs * tics
		public static const TICSHOURNIGHT:uint = 8 * 60; //secs * tics
		public static const NIGHTSTARTHOUR:uint = 21;
		public static const NIGHTENDHOUR:uint = 7;
		public static const ANIMALGROWNAGE:uint = 3; //Days till animal is grown.
		public static const ANIMALDIEAGE:uint = 6; //Days till animal dies.
		
		
		public static const COWPRICE:int = 100;
		public static const SHEEPPRICE:int = 100;
		public static const BULLETPRICE:int = 10;
		public static const FOODPRICE:int = 20;
		
		public static function getFullGrownSheepCount():String 
		{
			var count:uint = 0;
			for (var sheep:String in sheeps) 
			{
				if (G.sheeps[sheep].age >= ANIMALGROWNAGE) 
					count++;
			}
			return String(count);
		}
		
		public static function getFullGrownCowCount():String 
		{
			var count:uint = 0;
			for (var cow:String in cows) 
			{
				if (G.cows[cow].age >= ANIMALGROWNAGE) 
					count++;
			}
			return String(count);
		}
		
		public static function randomRange(minNum:Number, maxNum:Number):Number   
		{  
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);  
		}  
	}

}