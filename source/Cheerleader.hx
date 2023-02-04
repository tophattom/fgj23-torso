package;

import flixel.FlxG;
import flixel.addons.display.FlxNestedSprite;
import flixel.util.FlxColor;

typedef Pose = Int;

class Cheerleader extends FlxNestedSprite {
	static inline var ARM_UP_ANGLE = 150.0;
	static inline var LEG_UP_ANGLE = 60.0;

	static inline var JUMP_FORCE = 700.0;
	static inline var GRAVITY = 1500.0;

	public var pose(get, never):Pose;

	var leftArm:FlxNestedSprite;
	var rightArm:FlxNestedSprite;
	var leftLeg:FlxNestedSprite;
	var rightLeg:FlxNestedSprite;
	var torso:FlxNestedSprite;

	var startY:Float;
	var jumping = false;

	var leftArmUp:Bool;
	var rightArmUp:Bool;
	var leftLegUp:Bool;
	var rightLegUp:Bool;

	public function new(x:Float, y:Float) {
		super(x, y);
		scrollFactor.set(0, 0);

		startY = y;

		torso = new FlxNestedSprite();
		torso.relativeX = 12;
		torso.relativeY = 0;
		torso.makeGraphic(50, 100, FlxColor.GREEN);
		add(torso);

		leftArm = new FlxNestedSprite();
		leftArm.makeGraphic(12, 70, FlxColor.RED);
		leftArm.origin.set(6, 6);
		add(leftArm);

		rightArm = new FlxNestedSprite();
		rightArm.relativeX = 62;
		rightArm.relativeY = 0;
		rightArm.makeGraphic(12, 70, FlxColor.RED);
		rightArm.origin.set(6, 6);
		add(rightArm);

		leftLeg = new FlxNestedSprite();
		leftLeg.relativeX = 12;
		leftLeg.relativeY = 100;
		leftLeg.makeGraphic(12, 70, FlxColor.BLUE);
		leftLeg.origin.set(6, 6);
		add(leftLeg);

		rightLeg = new FlxNestedSprite();
		rightLeg.relativeX = 50;
		rightLeg.relativeY = 100;
		rightLeg.makeGraphic(12, 70, FlxColor.BLUE);
		rightLeg.origin.set(6, 6);
		add(rightLeg);
	}

	override function update(elapsed:Float) {
		updateMovement();
		updatePose();

		super.update(elapsed);
	}

	function updatePose() {
		var prevLeftLegUp = leftLegUp;
		var prevRightLegUp = rightLegUp;
		var canLiftLeftLeg = jumping || !prevRightLegUp;
		var canLiftRightLeg = jumping || !prevLeftLegUp;

		leftArmUp = FlxG.keys.pressed.D;
		rightArmUp = FlxG.keys.pressed.K;
		leftLegUp = canLiftLeftLeg && FlxG.keys.pressed.F;
		rightLegUp = canLiftRightLeg && FlxG.keys.pressed.J;

		if (!jumping && leftLegUp && rightLegUp) {
			leftLegUp = rightLegUp = false;
		}

		leftArm.relativeAngle = leftArmUp ? ARM_UP_ANGLE : 0.0;
		rightArm.relativeAngle = rightArmUp ? -ARM_UP_ANGLE : 0.0;

		leftLeg.relativeAngle = leftLegUp ? LEG_UP_ANGLE : 0.0;
		rightLeg.relativeAngle = rightLegUp ? -LEG_UP_ANGLE : 0.0;
	}

	function updateMovement() {
		var jumpPressed = FlxG.keys.justPressed.SPACE;

		if (!jumping && jumpPressed) {
			jumping = true;

			velocity.y = -JUMP_FORCE;
			acceleration.y = GRAVITY;
		}

		if (y > startY) {
			velocity.y = 0;
			acceleration.y = 0;
			y = startY;
			jumping = false;
		}
	}

	function get_pose() {
		var pose = 0;

		if (leftArmUp) {
			pose = pose ^ 1;
		}

		if (rightArmUp) {
			pose = pose ^ 2;
		}

		if (leftLegUp) {
			pose = pose ^ 4;
		}

		if (rightLegUp) {
			pose = pose ^ 8;
		}

		if (jumping) {
			pose = pose ^ 16;
		}

		return pose;
	}
}
