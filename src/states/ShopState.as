package states 
{
	import entities.Cow;
	import entities.Sheep;
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Raimonds Zarins
	 */
	public class ShopState extends FlxState 
	{
		private var background:FlxSprite;
		private var cowBuy:FlxButton;
		private var cowSell:FlxButton;
		private var sheepBuy:FlxButton;
		private var sheepSell:FlxButton;
		private var potatoeBuy:FlxButton;
		private var potatoeSell:FlxButton;
		private var sheepText:FlxText;
		private var cowText:FlxText;
		private var potatoeText:FlxText;
		private var coinsText:FlxText;
		private var leaveText:FlxText;
		public function ShopState() 
		{
			
		}
		
		override public function create():void 
		{
			super.create();
			background = new FlxSprite(0, 0, Assets.MarketBG);
			add(background);
			
			sheepBuy = new FlxButton(370, 155, "+", buySheep);
			add(sheepBuy);
			
			sheepSell = new FlxButton(370 + 100, 155, "-", sellSheep);
			add(sheepSell);
			
			cowBuy = new FlxButton(370, 310, "+", buyCow);
			add(cowBuy);
			
			cowSell = new FlxButton(370 + 100, 310, "-", sellCow);
			add(cowSell);
			
			potatoeBuy = new FlxButton(370, 470, "+", buyPotatoe);
			add(potatoeBuy);
			
			potatoeSell = new FlxButton(370 + 100, 470, "-", sellPotatoe);
			add(potatoeSell);
			
			sheepText = new FlxText(100, 240, 250, "");
			sheepText.setFormat(null, 16);
			add(sheepText);
			
			cowText = new FlxText(100, 400, 250, "");
			cowText.setFormat(null, 16);
			add(cowText);
			
			potatoeText = new FlxText(100, 540, 250, "");
			potatoeText.setFormat(null, 16);
			add(potatoeText);
			
			coinsText = new FlxText(FlxG.width - 200, FlxG.height - 50, 200, "Coins:");
			coinsText.setFormat(null, 16, 0xedff51);
			add(coinsText);
			
			leaveText = new FlxText(coinsText.x, coinsText.y + 15, 200, "To leave press <x>");
			leaveText.setFormat(null, 16, 0xc0ff00);
			add(leaveText);
		}
		
		private function sellPotatoe():void 
		{
			if (G.food > 0)
			{
				G.food--;
				G.coins += int(G.FOODPRICE * 0.7);
			}
		}
		
		private function buyPotatoe():void 
		{
			if (G.coins >= G.FOODPRICE)
			{
				G.coins -= G.FOODPRICE;
				G.food++;
			}
		}
		
		private function sellCow():void 
		{
			if (int(G.getFullGrownCowCount()) > 0)
			{
				for (var cow:String in G.cows)
				{
					if (G.cows[cow].age >= G.ANIMALGROWNAGE)
					{
						G.cows[cow] = null;
						G.coins += int(G.COWPRICE * 1.3);
						break;
					}
				}
			}
		}
		
		private function buyCow():void 
		{
			if (G.coins >= G.COWPRICE)
			{
				G.coins -= G.COWPRICE;
				G.cows.push(new Cow(G.randomRange(10, FlxG.width - 150), G.randomRange(325, FlxG.height - 65)));
			}
		}
		
		private function sellSheep():void 
		{
			if (int(G.getFullGrownSheepCount()) > 0)
			{
				for (var sheep:String in G.sheeps)
				{
					trace("trying to sell sheep!");
					if (G.sheeps[sheep].age >= G.ANIMALGROWNAGE)
					{
						G.sheeps.splice(sheep, 1);
						trace("selling sheep!");
						G.coins += int(G.SHEEPPRICE * 1.3);
						break;
					}
				}
			}
		}
		
		private function buySheep():void 
		{
			if (G.coins >= G.SHEEPPRICE)
			{
				G.coins -= G.SHEEPPRICE;
				G.sheeps.push(new Sheep(G.randomRange(10, FlxG.width - 150), G.randomRange(325, FlxG.height - 65)));
			}
		}
		
		
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.X)
				FlxG.switchState(new GameState);
				
			cowText.text =  G.getFullGrownCowCount() +"/" + G.cows.length + "\t Price: " + G.COWPRICE + "/" + String(int(G.COWPRICE * 1.30));
			sheepText.text = G.getFullGrownSheepCount() + "/" + G.sheeps.length + "\t Price: " + G.SHEEPPRICE + "/" + String(int(G.SHEEPPRICE * 1.30));
			potatoeText.text = String(G.food)+ "\t Price: " + G.FOODPRICE + "/" + String(int(G.FOODPRICE * 0.70));
			coinsText.text = "Coins: " + String(G.coins);
			
			if (G.coins < G.SHEEPPRICE)
			{
				sheepBuy.visible = false;
			} else {
				sheepBuy.visible = true;
			}
			
			if (G.coins < G.COWPRICE)
			{
				cowBuy.visible = false;
			} else {
				cowBuy.visible = true;
			}
			
			if (G.coins < G.FOODPRICE)
			{
				potatoeBuy.visible = false;
			} else {
				potatoeBuy.visible = true;
			}
		}
		
	}

}