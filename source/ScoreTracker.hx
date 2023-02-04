package;

import Cheerleader.Pose;
import flixel.util.FlxTimer;

class ScoreTracker {
	static inline var SAMPLE_INTERVAL = 0.5;
	static inline var MAX_SAMPLES = 10;

	var cheerleader:Cheerleader;
	var timer:FlxTimer;

	var previousPoses:Array<Pose> = [];

	public var score(default, null):Int = 0;

	public function new(cheerleader:Cheerleader) {
		this.cheerleader = cheerleader;
		timer = new FlxTimer();
		timer.start(SAMPLE_INTERVAL, trackScore, 0);
	}

	function trackScore(t) {
		previousPoses.unshift(cheerleader.pose);
		if (previousPoses.length > MAX_SAMPLES) {
			previousPoses.pop();
		}

		trace(previousPoses);
	}
}
