package;

import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class ScorePopup extends FlxText {
	static inline var DISTANCE = 40.0;
	static inline var DURATION = 0.5;

	public function new(x:Float, y:Float, amount:Float) {
		super(x, y, 0, "+" + Std.int(amount));
		setFormat(AssetPaths.LilitaOne_Regular__ttf, 40, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		FlxTween.tween(this, { alpha: 0, y: y - DISTANCE }, DURATION, { onComplete: (_) -> this.destroy() });
	}
}
