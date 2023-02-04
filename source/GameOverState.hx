package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class GameOverState extends FlxState {
	var background:FlxSprite;
	var cheerleader:FlxSprite;
	var winText:FlxText;
	var scoreText:FlxText;
	var retryButton:FlxButton;
	var menuButton:FlxButton;

	public var win:Bool;
	public var score:Float;

	function retry() {
		FlxG.switchState(new PlayState());
	}

	function menu() {
		FlxG.switchState(new MenuState());
	}

	override public function create() {
		background = new FlxSprite(0, 0, AssetPaths.game_over_bg__png);
		add(background);

		cheerleader = new FlxSprite(16, 167);
		cheerleader.loadGraphic(AssetPaths.cl_gameover__png, true, 238, 281);
		cheerleader.animation.add('win', [0]);
		cheerleader.animation.add('loss', [1]);
		win ? cheerleader.animation.play('win') : cheerleader.animation.play('loss');
		add(cheerleader);

		winText = new FlxText(0, 34, 0, win ? "VICTORY!" : "YOU SUCK.");
		winText.setFormat(AssetPaths.LilitaOne_Regular__ttf, 64, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		winText.alignment = FlxTextAlign.CENTER;
		winText.screenCenter(X);
		add(winText);

		scoreText = new FlxText(0, 164, 0, "Your score: " + Std.int(score));
		scoreText.setFormat(AssetPaths.LilitaOne_Regular__ttf, 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreText.alignment = FlxTextAlign.CENTER;
		scoreText.screenCenter(X);
		add(scoreText);

		retryButton = new FlxButton(326, 236, null, retry);
		retryButton.loadGraphic(AssetPaths.retry__png, true, 148, 47);
		add(retryButton);

		menuButton = new FlxButton(326, 307, null, menu);
		menuButton.loadGraphic(AssetPaths.menu__png, true, 148, 47);
		add(menuButton);
	}
}