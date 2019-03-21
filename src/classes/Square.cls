public class Square extends Rectangle {
    public Square() {
        super();
    }
    
    public Square(Integer width) {
        super.setWidth(width);
        super.setHeight(width);
    }
    
    public override void draw() {
        System.debug('Drawing a Square with width: ' + super.getWidth());
    }
    
    public override Integer calculateArea() {
        return super.getWidth() * super.getWidth();
    }
    
    public override Integer calculatePerimeter() {
        return 4 * super.getWidth();
    }
}