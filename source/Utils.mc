import Toybox.Time;
import Toybox.Lang;

module ATWUtils {

    (:background)
    public function formatTime(t as Time.Moment) as String {
        var info = Time.Gregorian.info(t, Time.FORMAT_MEDIUM);
        return Lang.format("$1$:$2$:$3$", [info.hour, info.min, info.sec]);
    }
}