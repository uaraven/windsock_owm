import Toybox.Time;
import Toybox.Lang;
import Toybox.Application;

module ATWUtils {

    const NO_DEBUG = 0;
    const CALC_COG = 1;
    const HEADING = 2;
    const STORAGE = 3;

    public function initDebug() {
        try {
            Application.Storage.getValue("debug_mode");
        } catch(e) {
            Application.Storage.setValue("debug_mode", 0);
            Application.Storage.setValue("wind", 3);
            Application.Storage.setValue("wind_speed", 1.6);
            Application.Storage.setValue("heading", 55);
        }
    }

    public function getDebugMode() {
        return safeGetStorage("debug_mode");
    }

    public function debugReadWind() {
        return safeGetStorage("wind");
    }

    public function debugReadWindSpeed() {
        var ws = safeGetStorage("wind_speed");
        if (ws == 0) {
            ws = 1;
        }
        return ws;
    }

    public function debugReadHeading() {
        return safeGetStorage("heading");
    }

    public function safeGetStorage(key) {
        try {
            var value = Application.Storage.getValue(key);
            if (value == null) {
                value = 0;
            }
            return value;
        } catch(e) {
            return 0;
        }
    }

    (:background)
    public function formatTime(t as Time.Moment) as String {
        var info = Time.Gregorian.info(t, Time.FORMAT_MEDIUM);
        return Lang.format("$1$:$2$:$3$", [info.hour, info.min, info.sec]);
    }

    class Averager {
        private var values = [];
        private var pointer;
        private var size;

        public function initialize(count as Numeric) {
            self.size = count;
            self.values = new[count];
            for (var i = 0; i < count ;i++) {
                self.values[i] = 0;
            }
            self.pointer = 0;
        }

        public function add(value) {
            self.values[self.pointer] = value;
            self.pointer += 1;
            if (self.pointer >= self.size) {
                self.pointer = 0;
            }
        }

        public function get() {
            var result = 0;
            for (var i = 0; i < self.size; i++) {
                result += self.values[i];
            }
            result /= self.size;
            return result;
        }
    }
}