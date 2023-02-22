import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;
import Toybox.Timer;

class ColdPlungeDelegate extends WatchUi.BehaviorDelegate {
    private static var LONG_DURATION = 1500;
    private static var MIDDLE_DURATION = 700;

    private var _view = getView();
    private var _timer;

    private var _inProgress = false;

    private var _currentDuration;

    private var _prepareStepCompleted = false;

    // Constructor
    function initialize() {
        BehaviorDelegate.initialize();
    }

    // On Menu click
    function onMenu() as Boolean {
        WatchUi.pushView(new MainMenu().getView(), new MainMenuViewDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    // On Select button click
    function onSelect() as Boolean {
        if (_inProgress == false) {
            _inProgress = true;

            if (ActivityManager.getRecordActivityFlag()) {
                ActivityManager.startSession();
            }
            
            startCountdown();
        }
        
        return true;
    }


    // On Back button click
    function onBack() as Boolean {
        ActivityManager.discardSession();

        return false;
    }

    // Starts countdown
    function startCountdown() {
        var prepareDuration = TimerManager.getPrepareDuration();

        if (prepareDuration > 0) {
            _currentDuration = prepareDuration - 1;
        } else {
            _currentDuration = TimerManager.getPlungeDuration() - 1;
            _prepareStepCompleted = true;
        }

        callAttention(LONG_DURATION);

        _timer = new Timer.Timer();
        _timer.start(method(:updateCountdownValue), 1000, true);
    }

    function updateCountdownValue() {
        // If its the last tick
        if (_currentDuration == 0 && _prepareStepCompleted) {
            callAttention(LONG_DURATION);
            _view.setTimerValue(0);

            _timer.stop();

            ActivityManager.stopSession();

            _inProgress = false;

            if (ActivityManager.getRecordActivityFlag()) {
                var completedView = new CompletedView();
                WatchUi.switchToView(completedView, new CompletedViewDelegate(completedView), WatchUi.SLIDE_UP);
            } else {
                var completedView = new CompletedPlainView();
                WatchUi.switchToView(completedView, new CompletedPlainViewDelegate(completedView), WatchUi.SLIDE_UP);
            }

            return;
        }

        // If its the last tick in the cycle
        if (_currentDuration == 0) {
            ActivityManager.addLap();

            _prepareStepCompleted = true;
            _currentDuration = TimerManager.getPlungeDuration();

            _view.setPlungeLabel();

            callAttention(MIDDLE_DURATION);
        }

        _view.setTimerValue(_currentDuration);
        _currentDuration--;
    }

    // Calls an attention by vibration and backlight
    function callAttention(duration as Number) as Void {
        var vibeData = [new Attention.VibeProfile(100, duration)];
        Attention.vibrate(vibeData);
        Attention.backlight(true);

        new Timer.Timer().start(method(:turnOffBacklight), 3000, false);
    }

    // Turns off backlight
    function turnOffBacklight() as Void {
        Attention.backlight(false);
    }
}