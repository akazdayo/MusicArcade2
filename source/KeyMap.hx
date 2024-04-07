package;

import Notes.Note;
import flixel.FlxG;
import openfl.system.System;

class Debug
{
	public static function keyMapping(notes:Array<Note>):Array<Note>
	{
		var min:Int = 5;
		var max:Int = 15;
		var speed:Int = Math.floor(Math.random() * (max - min + 1)) + min;

		#if html5
		exitKey();
		#end

		if (FlxG.keys.anyJustPressed(["H", "LEFT"]))
		{
			var _note = generateNote(0, speed, 0);
			notes.push(_note);
		}
		else if (FlxG.keys.anyJustPressed(["J", "DOWN"]))
		{
			var _note = generateNote(1, speed, 0);
			notes.push(_note);
		}
		else if (FlxG.keys.anyJustPressed(["K", "RIGHT"]))
		{
			var _note = generateNote(2, speed, 0);
			notes.push(_note);
		}
		return notes;
	}

	private static function exitKey()
	{
		if (FlxG.keys.anyPressed(["CONTROL"]) && FlxG.keys.anyJustPressed(["C"]))
		{
			System.exit(0);
		}
	}

	private static function generateNote(lane, speed, type):Note
	{
		var _note = new Note(lane, speed, type);
		_note.create();
		FlxG.state.add(_note.sprite);
		return _note;
	}
}
