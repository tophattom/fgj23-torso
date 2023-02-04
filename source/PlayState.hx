package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState {
	var background:FlxSprite;
	var track:FlxBackdrop;
	var runner:Runner;
	var player:Cheerleader;

	override public function create() {
		background = new FlxSprite(0, 0, AssetPaths.BG__png);
		background.screenCenter();
		background.scrollFactor.set(0, 0);
		add(background);

		track = new FlxBackdrop(AssetPaths.Track__png, X);
		track.y = 240;
		track.scrollFactor.set(1, 0);
		add(track);

		runner = new Runner(200, 30);
		runner.velocity.x = 100;
		add(runner);

		player = new Cheerleader(500, 280);
		add(player);

		FlxG.camera.follow(runner, LOCKON);
		FlxG.camera.targetOffset.x = 200;
		FlxG.camera.targetOffset.y = -70;

		var tracker = new ScoreTracker(player);

		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
