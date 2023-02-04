package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState {
	static inline var INITIAL_SPEED = 200.0;
	static inline var DRAG = 5.0;
	static inline var GRASS_BACK_SPEED_MULTIPLIER = 0.5;
	static inline var RAFTERS_SPEED_MULTIPLIER = 0.3;

	var background:FlxSprite;
	var grassBack:FlxBackdrop;
	var grassFront:FlxSprite;
	var rafters:FlxBackdrop;
	var track:FlxBackdrop;
	var runner:Runner;
	var player:Cheerleader;

	var speed:Float = INITIAL_SPEED;

	override public function create() {
		background = new FlxSprite(0, 0, AssetPaths.sky__png);
		add(background);

		grassBack = new FlxBackdrop(AssetPaths.grass_back__png, X);
		grassBack.y = 188;
		grassBack.velocity.x = -speed * GRASS_BACK_SPEED_MULTIPLIER;
		add(grassBack);

		grassFront = new FlxSprite(0, 377, AssetPaths.grass_front__png);
		add(grassFront);

		rafters = new FlxBackdrop(AssetPaths.rafters__png, X);
		rafters.y = 85;
		rafters.velocity.x = -speed * RAFTERS_SPEED_MULTIPLIER;
		add(rafters);

		track = new FlxBackdrop(AssetPaths.Track__png, X);
		track.y = 250;
		track.velocity.x = -speed;
		track.drag.x = DRAG;
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
		grassBack.velocity.x = track.velocity.x * GRASS_BACK_SPEED_MULTIPLIER;
		rafters.velocity.x = track.velocity.x * RAFTERS_SPEED_MULTIPLIER;
		super.update(elapsed);
	}
}
