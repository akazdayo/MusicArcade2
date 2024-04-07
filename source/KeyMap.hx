import Notes.Note;
import flixel.FlxG;

class KeyMapping
{
	public static function key(notes:Array<Note>):Array<Note>
	{
		var min:Int = 5;
		var max:Int = 15;
		var speed:Int = Math.floor(Math.random() * (max - min + 1)) + min;

		if (FlxG.keys.anyJustPressed(["A", "LEFT"]))
		{
			var _note = generateNote(0, speed, 0);
			notes.push(_note);
		}
		else if (FlxG.keys.anyJustPressed(["S", "DOWN"]))
		{
			var _note = generateNote(1, speed, 0);
			notes.push(_note);
		}
		else if (FlxG.keys.anyJustPressed(["D", "RIGHT"]))
		{
			var _note = generateNote(2, speed, 0);
			notes.push(_note);
		}
		return notes;
	}

	private static function generateNote(lane, speed, type):Note
	{
		var _note = new Note(lane, speed, type);
		_note.create();
		FlxG.state.add(_note.sprite);
		return _note;
	}
}
