import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Background;
import Toybox.Time;

import OWM;

(:background)
class ATWApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();

        System.println("register for temporal event");
        Background.registerForTemporalEvent(new Time.Duration(5*60));
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        if (!OWM.inBackground) {
            System.println("Deleting temporal event");
            Background.deleteTemporalEvent();
        } else {
            System.println("Background app stop");
        }
    }

    //! Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new ATWView() ] as Array<Views or InputDelegates>;
    }

    function getServiceDelegate() as ServiceDelegate {
        return [new OWM.OWMServiceDelegate()];
    }

    function onBackgroundData(data) {
        System.println("Got background data: "+ data);
        OWM.windData = data;
    }

}

function getApp() as ATWApp {
    return Application.getApp() as ATWApp;
}