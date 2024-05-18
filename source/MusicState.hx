import flixel.FlxG;
import flixel.sound.FlxSound;
import openfl.events.Event;
import openfl.media.Sound;
import openfl.net.URLRequest;

class MusicState
{
	public var music:Sound;

	public function new()
	{
		this.music = null;
	}

	public function load(url:String)
	{
		var request = new URLRequest(url);
		var sound = new Sound();
		sound.load(request);

		this.music = sound;
	}

	public function play()
	{
		if (this.music == null)
			return;

		this.music.addEventListener(Event.COMPLETE, function(e)
		{
			this.music.play();
		});
	}
}
