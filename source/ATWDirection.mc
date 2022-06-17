using Toybox.Math;
import OWM;

class Direction {
    private var north as Vector2;
    private var point1 as Vector2;
    private var point2 as Vector2;
    private var heading as Double;

    public function initialize() {
        self.north = new Vector2(0, 1);
        self.point1 = new Vector2(0, 0);
        self.point2 = new Vector2(0, 0);
        self.heading = 0;
    }

    public function addLocation(deg) {
        self.point1 = self.point2;
        self.point2 = new Vector2(deg[0], deg[1]);

        var diff = self.point2.subtract(self.point1);
        self.heading = north.angleBetween(diff);
    }

    public function getHeading() as Double {
        return self.heading;
    }

}