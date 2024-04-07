package;

import Judge.JudgeLine;
import KeyMap.Debug;
import Notes.Note;
import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	var notes:Array<Note>;
	var judgeLine:JudgeLine;

	override public function create()
	{
		super.create();

		// マウスを非表示に
		FlxG.mouse.visible = false;

		// ノーツの配列を初期化
		notes = new Array<Note>();

		// 判定クラスの初期化
		judgeLine = new JudgeLine();
	}

	override public function update(elapsed:Float)
	{
		// KeyMapping
		notes = Debug.keyMapping(notes);
		notes = judgeLine.keyMapping(notes);

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
