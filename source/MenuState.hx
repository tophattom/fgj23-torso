package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;

class MenuState extends FlxState {
	var background:FlxSprite;
	var newGameButton:FlxButton;
	var volumeSlider:VolumeSlider;

	var music:FlxSound;

	function newGame() {
		music.stop();
		FlxG.switchState(new PlayState());
	}

	override public function create() {
		super.create();

		background = new FlxSprite(0, 0, AssetPaths.menu_bg__png);
		add(background);

		newGameButton = new FlxButton(326, 380, null, newGame);
		newGameButton.loadGraphic(AssetPaths.new_game__png, true, 148, 47);
		add(newGameButton);

		volumeSlider = new VolumeSlider(24, 21);
		add(volumeSlider);

		FlxG.sound.cache(AssetPaths.main_song__ogg);
		if (music == null) {
			music = FlxG.sound.play(AssetPaths.menu_song__ogg, 1.0, true, FlxG.sound.defaultMusicGroup);
		}
	}
}
