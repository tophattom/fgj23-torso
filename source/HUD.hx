package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite> {
	var scoreText:FlxText;

	public function new() {
		super();

		scoreText = new FlxText(20, 410, 0, "Score: 0");
		scoreText.setFormat(AssetPaths.LilitaOne_Regular__ttf, 40, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		add(scoreText);

		forEach((s) -> s.scrollFactor.set(0, 0));
	}

	public function updateScore(newScore:Float) {
		scoreText.text = "Score: " + Std.int(newScore);
	}
}
