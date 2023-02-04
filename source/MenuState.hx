package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState {
	var background:FlxSprite;
	var newGameButton:FlxButton;

	function newGame() {
		FlxG.switchState(new PlayState());
	}

	override public function create() {
		background = new FlxSprite(0, 0, AssetPaths.menu_bg__png);
		add(background);

		newGameButton = new FlxButton(326, 391, null, newGame);
		newGameButton.loadGraphic(AssetPaths.new_game__png, true, 148, 47);
		add(newGameButton);
	}
}
