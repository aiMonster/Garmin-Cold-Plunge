import Toybox.System;
import Toybox.WatchUi;

class MainMenu {
    private static var _menu;

    function initialize() {
        if(_menu == null) {
            setMenu();
        }
    }

    function getView() {
        return _menu;
    }

    function updateSublabel(id, value) {
        switch(id) {
            case "plunge_duration":
                _menu.getItem(0).setSubLabel(value.toString() + "sec");
                break;
            case "prepare_duration":
                _menu.getItem(1).setSubLabel(value.toString() + "sec");
                break;
        }
    }

    private function setMenu() {
        _menu = new WatchUi.Menu2(null);

        var plungeDurationLbl = TimerManager.getPlungeDuration().toString() + "sec";
        var prepareDurationLbl = TimerManager.getPrepareDuration().toString() + "sec";
   
        _menu.addItem(new WatchUi.MenuItem("Plunge duration", plungeDurationLbl, "plunge_duration", null));
        _menu.addItem(new WatchUi.MenuItem("Prepare duration", prepareDurationLbl, "prepare_duration", null));
        _menu.addItem(new WatchUi.ToggleMenuItem(
            "Record activity", 
            {:enabled=>"Yes", :disabled=>"No"},
            "record_activity",
            ActivityManager.getRecordActivityFlag(),
            null
        ));
    }
}