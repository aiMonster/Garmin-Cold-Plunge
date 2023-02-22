import Toybox.WatchUi;

class MainMenuViewDelegate extends WatchUi.Menu2InputDelegate {
    private var _mainMenuView;

    // Constructor
    function initialize() {
        _mainMenuView = new MainMenu();
        Menu2InputDelegate.initialize();
    }

    // On Select button clicked
    function onSelect(item as MenuItem) as Void {
        var id = item.getId().toString();

        if (id.equals("record_activity")) {
            ActivityManager.setRecordActivityFlag(item.isEnabled());
            return;
        }

        var label = null, color = null, initialValue = null, callback = null;
        var showSeconds = false;

        if (id.equals("plunge_duration")) {
            label = TimerViewManager.PLUNGE_TITLE;
            color = ColorManager.get(TimerViewManager.PLUNGE_COLOR);
            initialValue = TimerManager.getPlungeDuration();
            showSeconds = true;
            callback = method(:updatePlungeDurationSettings); 
        } else if(id.equals("prepare_duration")) {
            label = TimerViewManager.PREPARE_TITLE;
            color = ColorManager.get(TimerViewManager.PREPARE_COLOR);
            initialValue = TimerManager.getPrepareDuration();
            showSeconds = true;
            callback = method(:updatePrepareDurationSettings); 
        }

        var picker = new NumberPicker(label, color, showSeconds, initialValue);
        var delegate = new NumberPickerDelegate(callback);

        WatchUi.pushView(picker, delegate, WatchUi.SLIDE_IMMEDIATE);
    }

    function updatePlungeDurationSettings(value as Number) as Void {
        _mainMenuView.updateSublabel("plunge_duration", value);
        TimerManager.setPlungeDuration(value);
    }

    function updatePrepareDurationSettings(value as Number) as Void {
        _mainMenuView.updateSublabel("prepare_duration", value);
        TimerManager.setPrepareDuration(value);
    }
}