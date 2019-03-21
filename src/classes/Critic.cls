public class Critic extends Person {
    public Integer yearsOfExperience {
        get {
            return yearsOfExperience;
        }
        set {
            if (value < 0) {
                System.debug('You can\'t possibly be that bad!');
            } else {
            	yearsOfExperience = value;
            }
        }
    }
    
    Public Critic() {
        yearsOfExperience = 0;
    }
    
    Public Critic(String name, String email) {
        super(name);
        setEmail(email);
    }
    
    Public override void display() {
        System.debug('Critis Information');
        super.display();
        System.debug('Years of Experience: ' + this.yearsOfExperience);
    }
}