package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

enum GameState {
	PLAYING;
	LOST;
	WON;
}

class PlayState extends FlxState {
	static inline var INITIAL_SPEED = 200.0;
	static inline var INITIAL_DRAG = 10.0;
	static inline var DRAG_MULTIPLIER = 1.0002;
	static inline var GRASS_BACK_SPEED_MULTIPLIER = 0.5;
	static inline var RAFTERS_SPEED_MULTIPLIER = 0.3;

	static inline var PLAYER_X = 500;
	static inline var PLAYER_Y = 190;

	static inline var POPUP_OFFSET_Y = -35;

	var background:FlxSprite;
	var grassBack:FlxBackdrop;
	var grassFront:FlxSprite;
	var rafters:FlxBackdrop;
	var track:FlxBackdrop;
	var runner:Runner;
	var player:Cheerleader;
	var playerShadow:FlxSprite;
	var hud:HUD;

	var scoreTracker:ScoreTracker;

	var music:FlxSound;

	var gameState = GameState.PLAYING;

	override public function create() {
		Utils.cameraFadeIn();

		super.create();

		background = new FlxSprite(0, 0, AssetPaths.sky__png);
		add(background);

		grassBack = new FlxBackdrop(AssetPaths.grass_back__png, X);
		grassBack.y = 188;
		grassBack.velocity.x = -INITIAL_SPEED * GRASS_BACK_SPEED_MULTIPLIER;
		add(grassBack);

		grassFront = new FlxSprite(0, 377, AssetPaths.grass_front__png);
		add(grassFront);

		rafters = new FlxBackdrop(AssetPaths.rafters__png, X);
		rafters.y = 85;
		rafters.velocity.x = -INITIAL_SPEED * RAFTERS_SPEED_MULTIPLIER;
		add(rafters);

		track = new FlxBackdrop(AssetPaths.racetrack__png, X);
		track.y = 250;
		track.velocity.x = -INITIAL_SPEED;
		track.drag.x = INITIAL_DRAG;
		add(track);

		runner = new Runner(100, 100);
		add(runner);

		playerShadow = new FlxSprite(PLAYER_X, PLAYER_Y + 250);
		playerShadow.makeGraphic(80, 20, FlxColor.TRANSPARENT, true);
		playerShadow.drawEllipse(0, 0, 80, 20, FlxColor.BLACK);
		playerShadow.alpha = 0.5;
		add(playerShadow);

		player = new Cheerleader(PLAYER_X, PLAYER_Y);
		add(player);

		hud = new HUD();
		add(hud);

		scoreTracker = new ScoreTracker(player, onScoreChange);

		if (music == null) {
			music = FlxG.sound.play(AssetPaths.main_song__ogg, 0.0, false, null, true, endGame);
			music.fadeIn(Utils.FADE_DURATION);
		}
	}

	override public function update(elapsed:Float) {
		if (gameState != GameState.PLAYING) {
			return;
		}

		if (track.velocity.x >= 0) {
			gameState = GameState.LOST;
			transitionToFailure();
		}

		runner.setAnimSpeed(Math.abs(track.velocity.x));
		grassBack.velocity.x = track.velocity.x * GRASS_BACK_SPEED_MULTIPLIER;
		rafters.velocity.x = track.velocity.x * RAFTERS_SPEED_MULTIPLIER;

		var shadowScale = Math.max(1.0, (PLAYER_Y / player.y) * 0.8);
		var shadowAlpha = (player.y / PLAYER_Y) * 0.4;
		playerShadow.scale.set(shadowScale, shadowScale);
		playerShadow.alpha = shadowAlpha;

		track.drag.x *= DRAG_MULTIPLIER;

		if (FlxG.keys.justPressed.ESCAPE) {
			music.pause();
			openSubState(new PauseState(music));
		}

		super.update(elapsed);
	}

	function endGame() {
		gameState = GameState.WON;
		var gameOverState = new GameOverState();
		gameOverState.win = true;
		gameOverState.score = scoreTracker.score;

		Utils.cameraFadeOut(Utils.FADE_DURATION, function() {
			FlxG.switchState(gameOverState);
		});
	}

	function transitionToFailure() {
		var gameOverState = new GameOverState();
		gameOverState.win = false;
		gameOverState.score = scoreTracker.score;

		Utils.cameraFadeOut();
		music.fadeOut(Utils.FADE_DURATION, 0, function(_) {
			FlxG.switchState(gameOverState);
		});
	}

	function onScoreChange(diff:Float) {
		track.velocity.x -= diff;

		if (diff > 0) {
			hud.updateScore(scoreTracker.score);
			add(new ScorePopup(PLAYER_X, player.y + POPUP_OFFSET_Y, diff));
		}
	}
}
