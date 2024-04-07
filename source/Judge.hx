package;

import Notes.Note;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class JudgeLine
{
	var judgeSprite:Array<FlxSprite>;
	var judgeSpriteImage:Array<Bool>;
	private var judgeArea:Float;

	public function new()
	{
		// 初期化
		judgeSpriteImage = [false, false, false];

		// JudgeAreaの追加
		judgeArea = FlxG.height - (FlxG.height / 5);

		// フレームの追加
		var frame = new FlxSprite(((FlxG.width / 2) + (0 * 150)) - 235, FlxG.height - (FlxG.height / 4.9));
		frame.loadGraphic("assets/images/judge/frame.png");
		FlxG.state.add(frame);

		// ボーダーラインの追加
		FlxG.state.add(new FlxSprite(FlxG.width / 3, 0).makeGraphic(8, FlxG.height, FlxColor.WHITE));
		FlxG.state.add(new FlxSprite(FlxG.width / 1.5, 0).makeGraphic(8, FlxG.height, FlxColor.WHITE));

		/*
			スプライトの画像をロード
			TODO : 画像をロードするときにエラーが出るので、一旦コメントアウト
			judgeImage = new Array<FlxGraphic>();
			judgeImage.push(FlxG.bitmap.add("assets/images/judge/off.png"));
			judgeImage.push(FlxG.bitmap.add("assets/images/judge/on.png"));
		 */

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

	public function judge(notes:Array<Note>, lane:Int):Array<Note>
	{
		var laneNotes:Array<Note> = [for (x in notes) if (x.lane == lane) x];

		for (note in laneNotes)
		{
			if ((judgeArea - 60) < note.sprite.y && (judgeArea - 30) > note.sprite.y) // Fast
			{
				note.sprite.destroy();
				notes.remove(note);
				return notes;
			}
			else if ((judgeArea - 30) < note.sprite.y && (judgeArea + 30) > note.sprite.y) // Perfect
			{
				note.sprite.destroy();
				notes.remove(note);
				return notes;
			}
			else if ((judgeArea + 30) < note.sprite.y && (judgeArea + 50) > note.sprite.y)
			{
				note.sprite.destroy();
				notes.remove(note);
				return notes;
			}
		}
		return notes;
	}

	public function keyMapping(notes:Array<Note>):Array<Note>
	{
		for (i in 0...3)
		{
			var key = ["A", "S", "D"][i];
			if (FlxG.keys.anyPressed([key]))
			{
				if (!judgeSpriteImage[i])
				{
					judgeSprite[i].loadGraphic("assets/images/judge/on.png");
					judgeSpriteImage[i] = true;
				}

				if (FlxG.keys.anyJustPressed([key]))
				{
					notes = judge(notes, i);
				}
			}
			else
			{
				if (judgeSpriteImage[i])
				{
					judgeSprite[i].loadGraphic("assets/images/judge/off.png");
					judgeSpriteImage[i] = false;
				}
			}
		}
		return notes;
	}
}
