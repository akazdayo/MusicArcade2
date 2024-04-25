import flixel.FlxG;
import flixel.sound.FlxSound;
import openfl.events.Event;
import openfl.media.Sound;
import openfl.net.URLRequest;

class MusicState
{
	public var music:FlxSound;

	public function new()
	{
		this.music = null;
	}

	public static function loadWeb(url:String)
	{
		var request = new URLRequest(url);
		var sound = new Sound();
		sound.addEventListener(Event.COMPLETE, function(e)
		{
			trace("Sound loaded: " + sound.length);
			sound.play();
			trace('Loaded: $url');
		});
		sound.load(request);
	}

	public function onComplete():Void
	{
		trace('Completed');
	}

	public function onLoad():Void
	{
		trace('Loaded: $music');
		this.music.play();
	}

	public function loadNeko(url:String)
	{
		trace('Loaded: $url');
		this.music = FlxG.sound.load(null, 1.0, false, null, true, false, "https://soundeffect-lab.info/sound/anime/mp3/drum-japanese1.mp3", this.onComplete,
			this.onLoad);
		trace(music.length);
	}
}
