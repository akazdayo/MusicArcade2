import lime.app.Future;
import lime.app.Promise;
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

	public static function loadJson(url:String):Future<Dynamic>
	{
		var promise = new Promise<Dynamic>();

		var req = new haxe.Http(url);
		req.onData = function(data:String)
		{
			promise.complete(haxe.Json.parse(data));
		};
		req.onError = function(error)
		{
			promise.error(error);
		};

		req.request(false);

		return promise.future;
	}
}
