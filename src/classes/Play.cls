public class Play {
	//Fields
    private String title;
    private String author;
    private String genre;
    
    //Constructors
    Public Play() {
        title = '';
        author = '';
        genre = '';
    }
    
    Public Play(String aTitle){
        title = aTitle;
        author = '';
        genre = '';
    }
    
    //Accessors
    public String getTitle() {
        return title;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public String getGenre() {
        return genre;
    }
    
    //Mutators
    public Void setTitle(String aTitle) {
        title = aTitle;
    }
    
    public void setAuthor(String anAuthor) {
        author = anAuthor;
    }
    
    public void setGenre(String aGenre) {
        genre = aGenre;
    }
    
    //Methods
    public void display() {
        System.debug('Play Information');
        System.debug('Title: ' + title);
        System.debug('Author: ' + author);
        System.debug('Genre: ' + genre);
    }
    
}