import openfl.events.Event;
import openfl.media.Sound;
import openfl.net.URLRequest;

class MusicState
{
	function new() {}

	public static function load(url:String)
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
}
