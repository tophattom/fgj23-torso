package;

import flixel.FlxG;
import flixel.addons.display.FlxNestedSprite;
import flixel.system.FlxSound;

typedef Pose = Int;

class Cheerleader extends FlxNestedSprite {
	static inline var ARM_UP_ANGLE = 135.0;
	static inline var LEG_UP_ANGLE = 90.0;

	static inline var JUMP_FORCE = 900.0;
	static inline var GRAVITY = 3700.0;

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

	var leftPompomSound:SoundSet;
	var rightPompomSound:SoundSet;
	var jumpSound:SoundSet;

	public static function poseSize(pose:Pose) {
		var size = 0;

		if (pose & 1 != 0) {
			size++;
		}

		if (pose & 2 != 0) {
			size++;
		}

		if (pose & 4 != 0) {
			size += 2;
		}

		if (pose & 8 != 0) {
			size += 2;
		}

		if (pose & 16 != 0) {
			size += 3;
		}

		return size;
	}

	public function new(x:Float, y:Float) {
		super(x, y);
		scrollFactor.set(0, 0);
		makeGraphic(0, 0);

		startY = y;

		leftLeg = new FlxNestedSprite();
		leftLeg.loadGraphic(AssetPaths.cl_leg_l__png, true, 90, 260);
		leftLeg.animation.add('down', [0]);
		leftLeg.animation.add('up', [1]);
		leftLeg.relativeX = -28;
		leftLeg.relativeY = 9;
		add(leftLeg);

		rightLeg = new FlxNestedSprite();
		rightLeg.loadGraphic(AssetPaths.cl_leg_r__png, true, 90, 260);
		rightLeg.animation.add('down', [0]);
		rightLeg.animation.add('up', [1]);
		rightLeg.relativeX = 5;
		rightLeg.relativeY = 6;
		add(rightLeg);

		torso = new FlxNestedSprite();
		torso.relativeX = 0;
		torso.relativeY = 0;
		torso.loadGraphic(AssetPaths.cl_torso__png);
		add(torso);

		leftArm = new FlxNestedSprite();
		leftArm.loadGraphic(AssetPaths.cl_arm_l__png, true, 70, 220);
		leftArm.animation.add('down', [0]);
		leftArm.animation.add('up', [1]);
		leftArm.relativeX = -16;
		leftArm.relativeY = -39;
		add(leftArm);

		rightArm = new FlxNestedSprite();
		rightArm.loadGraphic(AssetPaths.cl_arm_r__png, true, 70, 220);
		rightArm.animation.add('down', [0]);
		rightArm.animation.add('up', [1]);
		rightArm.relativeX = 26;
		rightArm.relativeY = -43;
		add(rightArm);

		leftPompomSound = new SoundSet([AssetPaths.pompom_l_1__wav, AssetPaths.pompom_l_2__wav]);
		rightPompomSound = new SoundSet([AssetPaths.pompom_r_1__wav, AssetPaths.pompom_r_2__wav]);
		jumpSound = new SoundSet([AssetPaths.jump_1__wav, AssetPaths.jump_2__wav], [0.7, 0.7]);
	}

	override function update(elapsed:Float) {
		updateMovement();
		updatePose();
		updateGraphics();

		super.update(elapsed);
	}

	function updatePose() {
		var prevLeftLegUp = leftLegUp;
		var prevRightLegUp = rightLegUp;
		var canLiftLeftLeg = jumping || !prevRightLegUp;
		var canLiftRightLeg = jumping || !prevLeftLegUp;
		var prevLeftArmUp = leftArmUp;
		var prevRightArmUp = rightArmUp;

		leftArmUp = FlxG.keys.pressed.D;
		rightArmUp = FlxG.keys.pressed.K;
		leftLegUp = canLiftLeftLeg && FlxG.keys.pressed.F;
		rightLegUp = canLiftRightLeg && FlxG.keys.pressed.J;

		if (leftArmUp && !prevLeftArmUp) {
			leftPompomSound.play();
		}

		if (rightArmUp && !prevRightArmUp) {
			rightPompomSound.play();
		}

		if (!jumping && leftLegUp && rightLegUp) {
			leftLegUp = rightLegUp = false;
		}
	}

	function updateGraphics() {
		if (leftArmUp) {
			leftArm.animation.play('up');
			leftArm.relativeAngle = ARM_UP_ANGLE;
		} else {
			leftArm.animation.play('down');
			leftArm.relativeAngle = 0.0;
		}

		if (rightArmUp) {
			rightArm.animation.play('up');
			rightArm.relativeAngle = -ARM_UP_ANGLE;
		} else {
			rightArm.animation.play('down');
			rightArm.relativeAngle = 0.0;
		}

		if (leftLegUp) {
			leftLeg.animation.play('up');
			leftLeg.relativeAngle = LEG_UP_ANGLE;
		} else {
			leftLeg.animation.play('down');
			leftLeg.relativeAngle = 0.0;
		}

		if (rightLegUp) {
			rightLeg.animation.play('up');
			rightLeg.relativeAngle = -LEG_UP_ANGLE;
		} else {
			rightLeg.animation.play('down');
			rightLeg.relativeAngle = 0.0;
		}
	}

	function updateMovement() {
		var jumpPressed = FlxG.keys.justPressed.SPACE;

		if (!jumping && jumpPressed) {
			jumping = true;

			velocity.y = -JUMP_FORCE;
			acceleration.y = GRAVITY;

			jumpSound.play();
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
