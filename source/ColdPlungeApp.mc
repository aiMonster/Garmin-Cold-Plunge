import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class ColdPlungeApp extends Application.AppBase {
    private var _view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        _view = new ColdPlungeView();

        return [_view, new ColdPlungeDelegate() ] as Array<Views or InputDelegates>;
    }

    // Returns main view instance
    function getView() as Void {
        return _view;
    }
}

// Returns application instance
function getApp() as ColdPlungeApp {
    return Application.getApp() as ColdPlungeApp;
}

// Returns main view instance
function getView() as ColdPlungeView {
    return Application.getApp().getView();
}