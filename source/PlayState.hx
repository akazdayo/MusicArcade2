package;

import Notes.Note;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var notes:Array<Note>;

	override public function create()
	{
		super.create();

		var text = new flixel.text.FlxText(0, 0, 0, "Hello, World!", 64);
		text.screenCenter();
		add(text);

		/*
			note = new Note(0, 10, 0);
			note.create();
			add(note.sprite);
		 */

		notes = new Array<Note>();
		notes.push(new Note(0, 10, 0));
		notes[0].create();
		add(notes[0].sprite);
	}

	override public function update(elapsed:Float)
	{
		if (notes.length == 1)
		{
			if (notes[0].update())
			{
				notes.pop();
			}
		}
		super.update(elapsed);
	}
}
