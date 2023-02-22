import Toybox.Graphics;

class TimerViewManager {
    static var PLUNGE_TITLE = "PLUNGE";
    static var PREPARE_TITLE = "PREPARE";

    static var PLUNGE_COLOR = Graphics.COLOR_BLUE;
    static var PREPARE_COLOR = Graphics.COLOR_ORANGE;

    static function formatTime(minutes as Number, seconds as Number) as String {
        var secondsFormatted = seconds > 9 ? seconds.toString() : "0" + seconds.toString();
        return minutes.toString() + ":" + secondsFormatted;
    }
}