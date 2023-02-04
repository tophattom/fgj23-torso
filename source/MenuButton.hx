package;

import flixel.FlxG;
import flixel.ui.FlxButton;

class MenuButton extends FlxButton {
	public function new(x:Float, y:Float) {
		super(x, y, null, switchToMenu);
		loadGraphic(AssetPaths.menu__png, true, 148, 47);
	}

	function switchToMenu() {
		FlxG.switchState(new MenuState());
	}
}
