using Toybox.Math;

class Vector2 {
    private var x as Numeric;
    private var y as Numeric;

    public function initialize(x as Numeric, y as Numeric) {
        self.x = x;
        self.y = y;
    }

    public function getX() {
        return self.x;
    }

    public function getY() {
        return self.y;
    }

    public function length() as Numeric {
        return Math.sqrt(self.x * self.x + self.y * self.y);
    }

    public function translate(dx as Numeric, dy as Numeric) as Vector2 {
        return new Vector2(self.x + dx, self.y + dy);
    }

    public function scale(d as Numeric) as Vector2 {
        return new Vector2(self.x*d, self.y*d);
    }

    public function rotate(rad as Numeric) as Vector2 {
        var nx = Math.cos(rad) * self.x - Math.sin(rad) * self.y;
        var ny = Math.sin(rad) * self.x + Math.cos(rad) * self.y;
        return new Vector2(nx, ny);
    }

    public function subtract(v as Vector2) as Vector2 {
        return new Vector2(self.x - v.getX(), self.y - v.getY());
    }

    public function scaleRotateTranslate(scale as Numeric, rot as Numeric, dx as Numeric, dy as Numeric) as Vector2 {
        var x = self.x * scale;
        var y = self.y * scale;
        var nx = Math.cos(rot) * x - Math.sin(rot) * y;
        var ny = Math.sin(rot) * x + Math.cos(rot) * y;
        return new Vector2(nx + dx, ny + dy);
    }

    public function dot(other as Vector2) as Double {
        return self.x * other.getX() + self.y * other.getY();
    }

    public function angleBetween(other as Vector2) as Double {
        var dot = self.dot(other);
        var den = self.length() * other.length();
        var a = 0;
        if (den != 0) {
            a = Math.acos(dot / den);
        }
        return Math.toDegrees(a);
    }

    public function asArray() as Array<Numeric> {
        return [self.x, self.y];
    }

}