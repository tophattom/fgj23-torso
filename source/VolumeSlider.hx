import flixel.FlxG;
import flixel.addons.ui.FlxSlider;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class VolumeSlider extends FlxSlider {
	override public function new(X:Float, Y:Float) {
		super(FlxG.sound, 'volume', X, Y, 0, 1, 150, 15, 6, 0xFFFFFFFF, 0xFFFF7B63);
		nameLabel.text = "Volume";
		minLabel.text = "";
		maxLabel.text = "";
		nameLabel.setFormat(AssetPaths.LilitaOne_Regular__ttf, 16, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		nameLabel.offset.y = 5;
		valueLabel.setFormat(AssetPaths.LilitaOne_Regular__ttf, 16, 0xFFFF7B63, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		decimals = 2;
		hoverAlpha = 1;
	}
}
