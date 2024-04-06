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
		// TODO: レーンに座標を対応させる
		this.sprite = new FlxSprite(0, 0);
		this.sprite.loadGraphic("assets/images/normal.png");
		// FlxG.state.add(this.sprite);
		// add(note.sprite);
	}

	public function update():Bool
	{
		if (FlxG.height >= sprite.y)
		{
			this.sprite.y += this.speed;
			return false;
		}
		else
		{
			this.sprite.destroy();
			trace("destroyed");
			return true;
		}
	}
}
