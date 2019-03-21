public virtual class Person {
    //Fields
    private String name;
    private String email;
    
    //Constructor
    public Person() {
        name = '';
    }
    
    public Person(String name) {
        this.name = name;
    }
    
    //Accessors or Getters
    public String getName(){
        //check user permissions
        return name;
    }
    
    public String getEmail(){
        //check user permissions
        return email;
    }
    
    //Mutators or Setters
    public void setName(String aName) {
        name = aName;
    }
    
    public void setEmail(String anEmail) {
        email = anEmail;
    }
    
    public virtual void display(){
        System.debug('Name: ' + name);
        System.debug('Email: ' + email);
    }
}