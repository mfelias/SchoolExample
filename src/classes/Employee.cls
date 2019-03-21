public class Employee extends Person {
    public String company {
        get {
            return company;
        }
        set {
            company = value;
        }
    }
    
    public employee() {
        company = '';
    }
    
    public employee(String name, String email) {
    	super(name);
        setEmail(email);
        this.company = '';
    }
    
    public override void display() {
		super.display();
        System.debug('Company: ' + this.company);
    }
}