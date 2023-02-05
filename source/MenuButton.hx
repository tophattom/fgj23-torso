package;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuButton extends FlxButton {
	public function new(x:Float, y:Float) {
		super(x, y, null, switchToMenu);
		loadGraphic(AssetPaths.menu__png, true, 148, 47);
	}

	function switchToMenu() {
		Utils.cameraFadeOut(Utils.FADE_DURATION, function() {
			FlxG.switchState(new MenuState());
		});
	}
}
