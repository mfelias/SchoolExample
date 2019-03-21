public class StaticClass {
	//static variable
	private static Integer numberOfObjectsCreated = 0;
    //instance method
    private Integer secondNumber = 0;
    
    public StaticClass() {
        numberOfObjectsCreated++;
        secondNumber++;
    }
    
    public void incrementNumberOfObjectsCreated() {
        numberOfObjectsCreated++;
    }
    
    public void incrementSecondNumber() {
        secondNumber++;
    }
    
    public Integer getNumberOfObjectsCreated() {
        return numberOfObjectsCreated;
    }
    
    public Integer getSecondNumber() {
        return secondNumber;
    }
}