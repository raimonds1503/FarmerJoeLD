package states
{
	import com.greensock.TweenLite;
	import entities.Animal;
	import entities.Cow;
	import entities.Sheep;
	import entities.Wolf;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Raimonds Zarins
	 */
	public class GameState extends FlxState
	{
		private var background:FlxSprite;
		private var stats:FlxText;
		private var actions:FlxText;
		private var time:FlxText;
		private var zero:String;
		private var zero_hour:String;
		private var isFeeded:Boolean = true;
		
		public function GameState()
		{
		
		}
		
		override public function create():void
		{
			super.create();
			background = new FlxSprite(0, 0, Assets.GameBGDay);
			add(background);
			
			stats = new FlxText(10, FlxG.height - 150, 300, "Stats: \n Status: Happy (: \n Sheep: 0 \n Cows: 0 \n Food: 0 \n Coins: 0");
			stats.setFormat(null, 12, 0xffffff);
			add(stats);
			
			actions = new FlxText(FlxG.width - 100, FlxG.height - 100, 150, "Actions: \n Shop <s> \n Feed <f>");
			actions.setFormat(null, 12, 0xffffff);
			add(actions);
			
			time = new FlxText(10, 10, 100, "10:00");
			time.setFormat(null, 20, 0x000000);
			add(time);
			
			//var v:Wolf = new Wolf(100, 100);
			//v.setGraphic();
			//add(v.graphic);
			
			//TweenLite.to(v.graphic, 2, { x: 500, y: 500 } );
			
			for (var sheep:String in G.sheeps)
			{
				var sh:Sheep = G.sheeps[sheep];
				sh.setGraphic();
				add(sh.graphic);
				
			}
			
			for (var cow:String in G.cows)
			{
				var ch:Cow = G.cows[cow];
				ch.setGraphic();
				add(ch.graphic);
			}
			
			G.volves = new FlxGroup(20);
			for (var i:int = 0; i < 10; i++)
			{
				var vlf:FlxSprite = new Wolf(-100, -100);
				
				G.volves.add(vlf);
			}
			add(G.volves);
			
			G.potatoes = new FlxGroup(20);
			for (var i:int = 0; i < 10; i++)
			{
				var pot:FlxSprite = new FlxSprite(-100, -100, Assets.Potatoe);
				
				G.potatoes.add(pot);
			}
			add(G.potatoes);
		
		}
		
		override public function update():void
		{
			super.update();
			stats.text = "Stats: \n Hungry: " + String(!isFeeded) + " \n Sheep: " + G.getFullGrownSheepCount() + "/" + G.sheeps.length + " \n Cows: " + G.getFullGrownCowCount() + "/" + G.cows.length + " \n Food: " + G.food + " \n Coins: " + G.coins + " \n Typed:" + G.typist + " <Tab> to clear";
			
			if (G.hours < 10)
			{
				zero_hour = "0";
			}
			else
			{
				zero_hour = "";
			}
			
			if (G.hours >= G.NIGHTSTARTHOUR || G.hours <= G.NIGHTENDHOUR)
			{
				time.color = 0xffffff;
				remove(background);
				background = new FlxSprite(0, 0, Assets.GameBGNight);
				G.ticksHour = G.TICSHOURNIGHT;
				if (G.randomRange(0, 1000 - G.day * 10) == 1 && (G.cows.length > 0 || G.sheeps.length > 0))
				{
					trace("Spawn enemy!");
					G.volvesIndex++;
					
					if (G.volvesIndex > 10)
					{
						G.volvesIndex = 0;
					}
					var v:Wolf = G.volves.members[G.volvesIndex];
					v.genWord();
					
					if (int(G.randomRange(0, 1)) == 0)
					{
						trace("Left!");
						v.reset(0, G.randomRange(325, FlxG.height - 65));
					}
					else
					{
						trace("Right!");
						v.reset(FlxG.width, G.randomRange(325, FlxG.height - 65));
					}
					
					var animal:Animal;
					if ((int(G.randomRange(0, 1)) == 0 && G.sheeps.length > 0) || G.cows.length == 0)
					{
						trace("Choosing Sheep!");
						animal = G.sheeps[G.randomRange(0, G.sheeps.length - 1)];
					}
					else
					{
						animal = G.cows[G.randomRange(0, G.cows.length - 1)];
					}
					
					trace("Starting Tween!");
					trace(v.x);
					trace(v.y);
					trace(animal.x);
					trace(animal.y);
					TweenLite.to(v, G.randomRange(6, 13), {x: animal.x, y: animal.y, onComplete: killAnimal, onCompleteParams: [v, animal]});
				}
				if ((int((G.timer / 60) * 7.5)) < 10)
				{
					zero = "0";
				}
				else
				{
					zero = "";
				}
				time.text = zero_hour + G.hours + ":" + zero + int((G.timer / 60) * 7.5);
				add(background)
			}
			else
			{
				time.color = 0x000000;
				remove(background);
				background = new FlxSprite(0, 0, Assets.GameBGDay);
				G.ticksHour = G.TICSHOURDAY;
				if ((int((G.timer / 60) * 15)) < 10)
				{
					zero = "0";
				}
				else
				{
					zero = "";
				}
				time.text = zero_hour + G.hours + ":" + zero + int((G.timer / 60) * 15);
				add(background);
			}
			
			G.timer++;
			if (G.timer >= G.ticksHour)
			{
				G.timer = 0;
				G.hours++;
				if (G.hours == 24)
				{
					G.hours = 0;
					G.day++;
					for (var sheep:String in G.sheeps)
					{
						G.sheeps[sheep].age++;
						if (!G.sheeps[sheep].isFed)
						{
							G.sheeps.splice(sheep, 1);
						}
						G.sheeps[sheep].isFed = false;
						isFeeded = false;
					}
					for (var cow:String in G.cows)
					{
						G.cows[cow].age++;
						if (!G.cows[cow].isFed)
						{
							G.cows.splice(cow, 1);
						}
						G.cows[cow].isFed = false;
						isFeeded = false;
					}
				}
			}
			
			if (FlxG.keys.S)
			{
				FlxG.switchState(new ShopState);
			}
			
			if (FlxG.keys.justReleased("NUMPADZERO") || FlxG.keys.justReleased("ZERO"))
			{
				G.typist += "0";
			}
			if (FlxG.keys.justReleased("NUMPADONE") || FlxG.keys.justReleased("ONE"))
			{
				G.typist += "1";
			}
			if (FlxG.keys.justReleased("NUMPADTWO") || FlxG.keys.justReleased("TWO"))
			{
				G.typist += "2";
			}
			if (FlxG.keys.justReleased("NUMPADTHREE") || FlxG.keys.justReleased("THREE"))
			{
				G.typist += "3";
			}
			if (FlxG.keys.justReleased("NUMPADFOUR") || FlxG.keys.justReleased("FOUR"))
			{
				G.typist += "4";
			}
			if (FlxG.keys.justReleased("NUMPADFIVE") || FlxG.keys.justReleased("FIVE"))
			{
				G.typist += "5";
			}
			if (FlxG.keys.justReleased("NUMPADSIX") || FlxG.keys.justReleased("SIX"))
			{
				G.typist += "6";
			}
			if (FlxG.keys.justReleased("NUMPADSEVEN") || FlxG.keys.justReleased("SEVEN"))
			{
				G.typist += "7";
			}
			if (FlxG.keys.justReleased("NUMPADEIGHT") || FlxG.keys.justReleased("EIGHT"))
			{
				G.typist += "8";
			}
			if (FlxG.keys.justReleased("NUMPADNINE") || FlxG.keys.justReleased("NINE"))
			{
				G.typist += "9";
			}
			
			if (FlxG.keys.TAB)
			{
				G.typist = "";
			}
			
			if (FlxG.keys.F)
			{
				for (var sheepz:String in G.sheeps)
				{
					if (!G.sheeps[sheepz].isFed && G.food > 0)
					{
						G.sheeps[sheepz].isFed = true;
						isFeeded = true;
						G.food -= 1;
					}
				}
				for (var cow:String in G.cows)
				{
					if (!G.cows[cow].isFed && G.food > 0)
					{
						G.cows[cow].isFed = true;
						isFeeded = true;
						G.food -= 1;
					}
				}
			}
		}
		
		public function killAnimal(wolf:Wolf, sheep:Animal):void
		{
			TweenLite.to(wolf, 1, {x: -100, y: -100});
			TweenLite.to(sheep.graphic, 1, {x: -100, y: -100});
			for (var sheepz:String in G.sheeps)
			{
				if (G.sheeps[sheepz] == sheep)
				{
					G.sheeps.splice(sheepz, 1);
					FlxG.play(Assets.SheepSound);
				}
			}
			for (var cow:String in G.cows)
			{
				if (G.cows[cow] == sheep)
				{
					G.cows.splice(cow, 1);
					FlxG.play(Assets.CowSound);
				}
			}
		}
	}

}