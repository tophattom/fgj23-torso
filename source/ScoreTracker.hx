package;

import Cheerleader.Pose;
import flixel.util.FlxTimer;

using Lambda;

typedef ScoreCallbackFn = (diff:Float) -> Void;

class ScoreTracker {
	static inline var BPM = 132;
	static inline var SAMPLE_INTERVAL = 1 / (BPM / 60);
	static inline var MAX_SAMPLES = 20;
	static inline var SAMPLING_POINT_DELAY = 60 / 1000;

	static inline var SCORE_SIZE_MULTIPLIER = 3;

	var cheerleader:Cheerleader;
	var delayTimer:FlxTimer;
	var timer:FlxTimer;

	var previousPoses:Array<Pose> = [];
	var scoreCallback:ScoreCallbackFn;

	public var score(default, null):Float = 0;

	public function new(cheerleader:Cheerleader, onScoreChange:ScoreCallbackFn) {
		this.cheerleader = cheerleader;

		scoreCallback = onScoreChange;

		delayTimer = new FlxTimer();
		timer = new FlxTimer();
		delayTimer.start(SAMPLING_POINT_DELAY, (_) -> {
			timer.start(SAMPLE_INTERVAL, samplePose, 0);
		});
	}

	function samplePose(t:FlxTimer) {
		var currentPose = cheerleader.pose;
		var scoreDiff = getScoreDiff(currentPose);

		score += scoreDiff;

		scoreCallback(scoreDiff);

		previousPoses.unshift(currentPose);
		if (previousPoses.length > MAX_SAMPLES) {
			previousPoses.pop();
		}
	}

	function getScoreDiff(pose):Float {
		var poseSize = Cheerleader.poseSize(pose);
		var samePoseCount = previousPoses.count((p) -> p == pose);
		var diff = poseSize * SCORE_SIZE_MULTIPLIER - (samePoseCount * Math.max(1, poseSize / 2));

		return Math.max(0, diff);
	}
}
