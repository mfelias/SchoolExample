public virtual class Rectangle extends Shape {
	
    private Integer height;
    private Integer width;
    
    public Integer getHeight() {
        return this.height;
    }
    
    public Integer getWidth() {
        return this.width;
    }
    
    public virtual void setHeight(Integer height) {
        this.height = height;
    }
    
    public virtual void setWidth(Integer width) {
        this.width = width;
    }
    
    public Rectangle() {
        setNumberOfSides(4);
    }
    
    public Rectangle(Integer height, Integer width) {
		setNumberOfSides(4);
        this.height = height;
        this.width = width;
    }
    
    public virtual void draw() {
        System.debug('Drawing a Rectangle with width: ' + this.width + ', and height: ' + this.height);
    }
    
    public virtual Integer calculateArea() {
        return this.width * this.height;
    }
    
    public virtual Integer calculatePerimeter() {
        return 2 * (this.width + this.height);
    }
}