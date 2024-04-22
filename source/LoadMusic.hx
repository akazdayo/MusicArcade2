package;

import lime.app.Future;
import lime.app.Promise;

class LoadMusic
{
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
