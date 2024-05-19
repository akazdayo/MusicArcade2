package;

import flixel.FlxG;
import flixel.FlxSprite;

class Note
{
	public var lane:Int;
	public var speed:Float;
	public var type:Int;
	public var sprite:FlxSprite;

	public function new(lane:Int, speed:Float, type:Int)
	{
		this.lane = lane;
		this.speed = speed;
		this.type = type;
	}

	public function create()
	{
		var lanes = [
			((FlxG.width / 2) + (0 * 150)) - 225,
			((FlxG.width / 2) + (1 * 150)) - 225,
			((FlxG.width / 2) + (2 * 150)) - 225
		];

		this.sprite = new FlxSprite(lanes[this.lane], 0);
		this.sprite.loadGraphic("assets/images/normal.png");
	}

	public function update():Bool
	{
		if ((FlxG.height + sprite.height) >= sprite.y)
		{
			this.sprite.y += this.speed;
			return false;
		}
		else
		{
			this.sprite.destroy();
			return true;
		}
	}
}
