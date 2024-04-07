package;

import KeyMap.KeyMapping;
import Notes.Note;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var notes:Array<Note>;
	var judge:Array<FlxSprite>;

	override public function create()
	{
		super.create();

		// マウスを非表示に
		FlxG.mouse.visible = false;

		// ノーツの配列を初期化
		notes = new Array<Note>();

		// 判定のフレームを追加
		var frame = new FlxSprite(((FlxG.width / 2) + (0 * 150)) - 235, FlxG.height - (FlxG.height / 4.9));
		frame.loadGraphic("assets/images/judge/frame.png");
		add(frame);

		// 判定のスプライトを作成
		judge = new Array<FlxSprite>();
		for (i in 0...3)
		{
			var _judgeSprite = new FlxSprite(((FlxG.width / 2) + (i * 150)) - 225, FlxG.height - (FlxG.height / 5));
			_judgeSprite.loadGraphic("assets/images/judge/off.png");
			add(_judgeSprite);

			judge.push(_judgeSprite);
		}

		// ボーダーラインを追加
		add(new FlxSprite(FlxG.width / 3, 0).makeGraphic(8, FlxG.height, FlxColor.WHITE));
		add(new FlxSprite(FlxG.width / 1.5, 0).makeGraphic(8, FlxG.height, FlxColor.WHITE));
	}

	override public function update(elapsed:Float)
	{
		// KeyMapping
		notes = KeyMapping.key(notes);

		for (note in notes)
		{
			if (note.update())
			{
				notes.remove(note);
			}
		}
		super.update(elapsed);
	}
}
