import flixel.FlxG;
import flixel.system.FlxSound;

using Lambda;

class SoundSet {
	var soundArray:Array<FlxSound>;

	public function new(soundAssets:Array<String>, ?assetVolumes:Array<Float>) {
		function getVolume(index:Int) {
			return assetVolumes != null && index < assetVolumes.length ? assetVolumes[index] : 1.0;
		}

		soundArray = soundAssets.mapi((index, asset) -> FlxG.sound.load(asset, getVolume(index)));
	}

	public function play() {
		var index = FlxG.random.int(0, soundArray.length - 1);
		var sound = soundArray[index];
		if (sound.playing) {
			sound.stop();
		}

		sound.play();
	}
}
