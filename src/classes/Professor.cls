public class Professor extends Person {
	//Properties
	//MUST be public
    Public Decimal salary {
        get {
            if (salary == null) {
                salary = 0.0;
            }
            return salary;
        }
        set {
            // value is a keyword which represents the value a property is being set to
            if (value < 0.0) {
                System.debug('You can\'t have a  negative salary! That\'s called debt!');
            } else {
                salary = value;
            }
        }
    }
    
    //Default constructor calls default values from parent class
    Public Professor() {
        salary = 0.0;
    }
    
    Public Professor(String name, String email) {
        //calls constructor from super class which only calls one String
        super(name);
        setEmail(email);
        this.salary = 0.0;
    }
    
    Public override void display() {
        //ONLY CALL STUFF THAT IS STORED IN THE CLASS
        //IF ITS STORED IN THE SUPER, USE THE SUPER'S CALL
        super.display();
        SYstem.debug('Salary: ' + this.salary);
    }
}