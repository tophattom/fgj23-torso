package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class SplashState extends FlxState {
	static inline var MAX_SCALE = 1.1;

	override function create() {
		super.create();

		var bg = new FlxSprite(0, 0, AssetPaths.splash__png);
		bg.screenCenter();
		add(bg);

		var continueText = new FlxText(0, 290, 0, "Press any key to continue...");
		continueText.setFormat(AssetPaths.LilitaOne_Regular__ttf, 20, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		continueText.screenCenter(X);
		add(continueText);

		FlxTween.tween(continueText, { "scale.x": MAX_SCALE, "scale.y": MAX_SCALE }, 1, { type: PINGPONG, ease: FlxEase.sineInOut });
	}

	override function update(elapsed:Float) {
		if (FlxG.keys.firstJustPressed() != -1 || FlxG.mouse.justPressed) {
			FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}
}
