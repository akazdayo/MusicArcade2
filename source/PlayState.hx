package;

import Judge.JudgeLine;
import KeyMap.Debug;
import MusicState.MusicState;
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

		// ゲーム開始
		gameStart("http://127.0.0.1:8000/config/sample2.json");
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

	public function dropNotes(chart:Array<Array<Int>>, url:String)
	{
		var delay:Float = 0;
		var musicState = new MusicState();

		musicState.load(url); // 曲を読み込む
		musicState.play(); // 曲を再生

		// ノーツを生成
		for (x in chart)
		{
			new FlxTimer().start(delay, Void ->
			{
				for (i in 0...3) // 一列送信
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

	public function gameStart(url:String):Void
	{
		var chart = new Array<Array<Int>>();

		// var jsonReq = LoadMusic.loadJson(url);
		var jsonReq = MusicState.loadJson(url);
		jsonReq.onComplete(function(jsonData)
		{
			var req = new haxe.Http(jsonData.chart); // リクエストを作成
			req.onData = function(data)
			{
				// データを整える
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
				dropNotes(chart, jsonData.music); // データが取得できたらコールバックを呼び出す
			}
			req.onError = function(err)
			{
				throw err; // エラーを返す
			}
			req.request(false); // リクエストを送信
		});
	}
}
