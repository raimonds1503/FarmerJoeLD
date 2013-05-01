package entities 
{
	import com.greensock.TweenLite;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Raimonds Zarins
	 */
	public class Wolf extends FlxSprite
	{
		public var overhead:FlxText;
		private var potatoe:FlxSprite;
		public function Wolf(x:Number, y:Number) 
		{
			super(x, y, Assets.Wolf);
			overhead = new FlxText(x, y - 10, 128, "Test");
			overhead.setFormat(null, 10, 0xffffff, "center");
			FlxG.state.add(overhead);
		}
		
		override public function update():void 
		{
			overhead.x = x;
			overhead.y = y - 10;
			
			if (G.typist == overhead.text && G.food > 0)
			{
				var pot:FlxSprite = G.potatoes.members[G.potatoesIndex];
				potatoe = pot;
				G.potatoesIndex++;
				if (G.potatoesIndex > 9) {
					G.potatoesIndex = 0;
				}
				pot.reset(FlxG.width / 2, FlxG.height);
				TweenLite.to(pot, 0.5, { x: x, y: y, onComplete: flyAway} );
				G.typist = "";
			}
			
			super.update();
		}
		
		public function flyAway():void {
			TweenLite.to(this, 1, { x: -100, y: -100 } );
			TweenLite.to(potatoe, 1, { x: -100, y: -100 } );
			
		}
		
		public function genWord():void
		{
			overhead.text = String(G.randomRange(100000, 9999999));
		}
		
	}

}