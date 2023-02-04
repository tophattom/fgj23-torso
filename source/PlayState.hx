package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState {
	static inline var INITIAL_SPEED = 200.0;
	static inline var DRAG = 5.0;

	var background:FlxSprite;
	var track:FlxBackdrop;
	var runner:Runner;
	var player:Cheerleader;

	var speed:Float = INITIAL_SPEED;

	override public function create() {
		background = new FlxSprite(0, 0, AssetPaths.BG__png);
		background.screenCenter();
		background.scrollFactor.set(0, 0);
		add(background);

		track = new FlxBackdrop(AssetPaths.Track__png, X);
		track.y = 240;
		track.velocity.x = -speed;
		track.drag.x = DRAG;
		track.scrollFactor.set(1, 0);
		add(track);

		runner = new Runner(100, 100);
		add(runner);

		player = new Cheerleader(500, 190);
		add(player);

		var tracker = new ScoreTracker(player);

		super.create();
	}

	override public function update(elapsed:Float) {
		runner.setAnimSpeed(Math.abs(track.velocity.x));
		super.update(elapsed);
	}
}
