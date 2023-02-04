package;

import flixel.FlxSprite;

class Runner extends FlxSprite {
	static inline var WANDER_DISTANCE = 20;
	static inline var WANDER_RATE_DIVISOR = 5;

	var t:Float = 0;
	var startY:Float;

	public function new(x:Float, y:Float) {
		super(x, y);

		startY = y;

		loadGraphic(AssetPaths.runner__png, true, 220, 220);
		animation.add('run', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 10);
		animation.play('run');
	}

	override function update(elapsed:Float) {
		t += elapsed;
		y = startY + Math.sin(t / WANDER_RATE_DIVISOR) * WANDER_DISTANCE;

		super.update(elapsed);
	}
}
