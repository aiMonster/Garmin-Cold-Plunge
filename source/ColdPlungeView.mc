import Toybox.WatchUi;
import Toybox.Graphics;

class ColdPlungeView extends WatchUi.View {
    private var _typeTitleElement;
    private var _currentTimerElement;

    // Constructor
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _typeTitleElement = findDrawableById("type_title");
        _currentTimerElement = findDrawableById("current_timer");

        _typeTitleElement.setColor(ColorManager.get(Graphics.COLOR_BLUE));
        _currentTimerElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        setTimerValue(TimerManager.getPrepareDuration());
        setPrepareLabel();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function setPlungeLabel() as Void {
        _typeTitleElement.setText(TimerViewManager.PLUNGE_TITLE);
        _typeTitleElement.setColor(ColorManager.get(TimerViewManager.PLUNGE_COLOR));

        WatchUi.requestUpdate();
    }

    function setPrepareLabel() as Void {
        _typeTitleElement.setText(TimerViewManager.PREPARE_TITLE);
        _typeTitleElement.setColor(ColorManager.get(TimerViewManager.PREPARE_COLOR));

        WatchUi.requestUpdate();
    }

    // Updates timer value on the view
    function setTimerValue(value as Number) as Void {
        var current = TimerViewManager.formatTime(value/60, value%60);
        _currentTimerElement.setText(current);

        WatchUi.requestUpdate();
    }
}
