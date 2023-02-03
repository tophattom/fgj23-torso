package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

class Cheerleader extends FlxSpriteGroup {
	static inline var ARM_UP_ANGLE = 150.0;
	static inline var LEG_UP_ANGLE = 60.0;

	var leftArm:FlxSprite;
	var rightArm:FlxSprite;
	var leftLeg:FlxSprite;
	var rightLeg:FlxSprite;
	var torso:FlxSprite;

	public function new(x:Float, y:Float) {
		super(x, y);

		torso = new FlxSprite(12, 0);
		torso.makeGraphic(50, 100, FlxColor.GREEN);
		add(torso);

		leftArm = new FlxSprite(0, 0);
		leftArm.makeGraphic(12, 70, FlxColor.RED);
		leftArm.origin.set(6, 6);
		add(leftArm);

		rightArm = new FlxSprite(62, 0);
		rightArm.makeGraphic(12, 70, FlxColor.RED);
		rightArm.origin.set(6, 6);
		add(rightArm);

		leftLeg = new FlxSprite(12, 100);
		leftLeg.makeGraphic(12, 70, FlxColor.BLUE);
		leftLeg.origin.set(6, 6);
		add(leftLeg);

		rightLeg = new FlxSprite(50, 100);
		rightLeg.makeGraphic(12, 70, FlxColor.BLUE);
		rightLeg.origin.set(6, 6);
		add(rightLeg);
	}

	override function update(elapsed:Float) {
		updatePose();

		super.update(elapsed);
	}

	function updatePose() {
		var leftArmUp = FlxG.keys.pressed.D;
		var rightArmUp = FlxG.keys.pressed.K;
		var leftLegUp = FlxG.keys.pressed.F;
		var rightLegUp = FlxG.keys.pressed.J;

		leftArm.angle = leftArmUp ? ARM_UP_ANGLE : 0.0;
		rightArm.angle = rightArmUp ? -ARM_UP_ANGLE : 0.0;

		leftLeg.angle = leftLegUp ? LEG_UP_ANGLE : 0.0;
		rightLeg.angle = rightLegUp ? -LEG_UP_ANGLE : 0.0;
	}
}
