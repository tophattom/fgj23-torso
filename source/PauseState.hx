package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PauseState extends FlxSubState {
	public function new() {
		FlxTimer.globalManager.forEach((t) -> t.active = false);
		FlxG.sound.pause();

		super(FlxColor.fromRGB(0, 0, 0, 190));

		var pausedText = new FlxText(0, 150, 0, "Paused");
		pausedText.setFormat(AssetPaths.LilitaOne_Regular__ttf, 40, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		pausedText.screenCenter(X);
		add(pausedText);

		var volumeSlider = new VolumeSlider(24, 21);
		add(volumeSlider);

		var menuButton = new MenuButton(0, 250);
		menuButton.screenCenter(X);
		add(menuButton);
	}

	override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.ESCAPE) {
			FlxTimer.globalManager.forEach((t) -> t.active = true);
			FlxG.sound.resume();
			close();
		}

		super.update(elapsed);
	}
}
