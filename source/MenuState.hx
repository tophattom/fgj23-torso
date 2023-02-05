package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState {
	var background:FlxSprite;
	var newGameButton:FlxButton;
	var volumeSlider:VolumeSlider;

	var music:FlxSound;

	override public function create() {
		Utils.cameraFadeIn();

		super.create();

		background = new FlxSprite(0, 0, AssetPaths.menu_bg__png);
		add(background);

		newGameButton = new FlxButton(326, 380, null, transitionToNewGame);
		newGameButton.loadGraphic(AssetPaths.new_game__png, true, 148, 47);
		add(newGameButton);

		volumeSlider = new VolumeSlider(24, 21);
		add(volumeSlider);

		FlxG.sound.cache(AssetPaths.main_song__ogg);
		if (music == null) {
			music = FlxG.sound.play(AssetPaths.menu_song__ogg, 0, true, FlxG.sound.defaultMusicGroup);
			music.fadeIn(Utils.FADE_DURATION);
		}
	}

	function transitionToNewGame() {
		Utils.cameraFadeOut();
		music.fadeOut(Utils.FADE_DURATION, 0, function(_) {
			music.stop();
			FlxG.switchState(new PlayState());
		});
	}
}
