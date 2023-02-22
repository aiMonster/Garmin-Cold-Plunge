import Toybox.Application;

class TimerManager {
    static function getPlungeDuration() {
        return Application.Properties.getValue("plungeDuration");
    }

    static function setPlungeDuration(value) {
        Application.Properties.setValue("plungeDuration", value);
    }

    static function getPrepareDuration() {
        return Application.Properties.getValue("prepareDuration");
    }

    static function setPrepareDuration(value) {
        Application.Properties.setValue("prepareDuration", value);
    }   
}