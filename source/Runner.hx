package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Runner extends FlxSprite {
	public function new(x:Float, y:Float) {
		super(x, y);

		makeGraphic(70, 150, FlxColor.GRAY);
	}
}
