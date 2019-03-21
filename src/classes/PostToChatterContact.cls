public class PostToChatterContact {
    public static void postChatterContact(List<Contact> newContacts) {
        System.debug('postChatterContact is starting');
        
        for (Contact c : newContacts) {
            if (c.email == null) {
                System.debug('Contact with Last Name: ' + c.LastName + ' did not have an email specified.');
            } else {
                ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), 
                                                                                             c.ID, 
                                                                                             ConnectApi.FeedElementType.FeedItem, 
                                                                                             'Email this person!');
            }
        }
        
        System.debug('postChatterContact is ending');
    }
}