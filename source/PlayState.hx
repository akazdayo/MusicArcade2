package;

import KeyMap.KeyMapping;
import Notes.Note;
import flixel.FlxState;

class PlayState extends FlxState
{
	var notes:Array<Note>;

	override public function create()
	{
		super.create();
		notes = new Array<Note>();
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
				trace(notes.length);
			}
		}
		super.update(elapsed);
	}
}
