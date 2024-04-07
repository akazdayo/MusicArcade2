package;

import Judge.JudgeLine;
import KeyMap.Debug;
import Notes.Note;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;

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
		getChart('https://raw.githubusercontent.com/akazdayo/MusicArcade2/develop/assets/data/charts/test.csv', dropNotes);
	}

	override public function update(elapsed:Float)
	{
		// KeyMapping
		notes = Debug.keyMapping(notes);
		notes = judgeLine.keyMapping(notes);

		// ノーツの更新
		for (note in notes)
		{
			if (note.update())
			{
				notes.remove(note);
			}
		}
		super.update(elapsed);
	}

	public function dropNotes(chart:Array<Array<Int>>)
	{
		var delay:Float = 0;

		for (x in chart)
		{
			new FlxTimer().start(delay, Void ->
			{
				for (i in 0...3)
				{
					var j = x[i];
					if (j == 1)
					{
						var _note = new Note(i, 7, 0);
						_note.create();
						add(_note.sprite);
						notes.push(_note);
					}
				}
			});
			delay += 0.2;
		}
	}

	public function getChart(url:String, callBack:Array<Array<Int>>->Void):Void
	{
		var chart = new Array<Array<Int>>();

		var req = new haxe.Http(url);
		req.onData = function(data)
		{
			var rows = data.split('\n');
			for (row in rows)
			{
				var _cols = new Array<Int>();
				var cols = row.split(',');
				for (col in cols)
				{
					_cols.push(Std.parseInt(col));
				}
				chart.push(_cols);
			}
			callBack(chart); // データが取得できたらコールバックを呼び出す
		}
		req.onError = function(err)
		{
			throw err;
		}
		req.request(false);
	}
}
