package;

import flixel.FlxSprite;

class Runner extends FlxSprite {
	public function new(x:Float, y:Float) {
		super(x, y);

		loadGraphic(AssetPaths.runner__png, true, 220, 220);
		animation.add('run', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 10);
		animation.play('run');
	}
}
