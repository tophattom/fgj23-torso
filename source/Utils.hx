package;

import flixel.FlxG;
import flixel.util.FlxColor;

class Utils {
	public static inline var FADE_DURATION = 0.33;

	public static function cameraFadeOut(duration:Float = FADE_DURATION, ?onComplete:() -> Void = null) {
		FlxG.camera.fade(FlxColor.BLACK, duration, false, onComplete);
	}

	public static function cameraFadeIn(duration:Float = FADE_DURATION) {
		FlxG.camera.fade(FlxColor.BLACK, duration, true);
	}

	public static function findIndices<T>(arr:Array<T>, needle:T) {
		var result = [];
		var startIndex = 0;

		while (startIndex < arr.length) {
			var i = arr.indexOf(needle, startIndex);

			if (i == -1) {
				break;
			}

			result.push(i);
			startIndex = i + 1;
		}

		return result;
	}

	public static function averageDiff(arr:Array<Int>) {
		var diffSum = 0.0;

		for (i in 0...(arr.length - 1)) {
			diffSum += Math.abs(arr[i + 1] - arr[i]);
		}

		return diffSum / (arr.length - 1);
	}
}
