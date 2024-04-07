import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class JudgeLine
{
	var judgeSprite:Array<FlxSprite>;

	public function new()
	{
		// フレームの追加
		var frame = new FlxSprite(((FlxG.width / 2) + (0 * 150)) - 235, FlxG.height - (FlxG.height / 4.9));
		frame.loadGraphic("assets/images/judge/frame.png");
		FlxG.state.add(frame);

		// ボーダーラインの追加
		FlxG.state.add(new FlxSprite(FlxG.width / 3, 0).makeGraphic(8, FlxG.height, FlxColor.WHITE));
		FlxG.state.add(new FlxSprite(FlxG.width / 1.5, 0).makeGraphic(8, FlxG.height, FlxColor.WHITE));

		// スプライトを作成
		judgeSprite = new Array<FlxSprite>();
		for (i in 0...3)
		{
			var _judgeSprite = new FlxSprite(((FlxG.width / 2) + (i * 150)) - 225, FlxG.height - (FlxG.height / 5));
			_judgeSprite.loadGraphic("assets/images/judge/off.png");
			FlxG.state.add(_judgeSprite);

			judgeSprite.push(_judgeSprite);
		}
	}

	public function judge() {}
}
