import Toybox.Time;
import Toybox.Lang;

module ATWUtils {

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