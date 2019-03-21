public class ProjectZero {
    public static Integer fibonacci(Integer n) {
        // Simplest cases
        if ((n==0) || (n==1)) return n;
        else if (n==2) return 1;
        // Otherwise actually use loop
        else {
            // Initialize variables used to store and increment through Fibonacci
            Integer n1 = 0;
            Integer n2 = 1;
            Integer n3 = 1;
            
            // If n is positive, proceed forward
            // Otherwise, go backwards 
            if (n > 2) {
                // loop shifts stored values then calculates next term
                for (Integer i = 0; i < n-2; i++) {
                    n1 = n2;
                    n2 = n3;
                    n3 = n1 + n2;
                }
                return n3;
            } else {
                // it's possible to calculate the fibonacci backwards
                // it turns out to be the same values, but with alternating sign (+/-)
                for (Integer i = 0; i > n; i--) {
                    n3 = n2;
                    n2 = n1;
                    n1 = n3 - n2;
                }
                return n1;
            }            
        }  
    }
    public static List<Integer> sortArray(List<Integer> numArray) {
        Boolean done = true;
        do {
            // assume no changes are needed at start of array-check loop
            done = true;
            // loop through array comparing sequential items
            // if array has 5 entries, i should loop from 0 --> 3 
            // (item indexes are 0 --> 4 but no term after index 4 to compare to)
            for (Integer i = 0; i < numArray.size() - 1; i ++) {
                // if the two elements being compared are in the wrong order
                if (numArray[i] > numArray[i+1]) {
                    // something needs to be changed so we should run through the loop again to make sure its actually sorted
                    done = false;
                    // effectively switches the two elements being compared
                    // removes the lesser element which is being moved forward and inserts it ahead of the greater element
                    numArray.add(i, numArray.remove(i+1));
                }
            }
        } while (!done);
        return numArray;
    }
    
    public static Integer factorial(Integer n) {
        // check valid input
        if (n < 0) {
            System.debug('Invalid Input! Only Positive Integers Allowed!');
            return 0;
        }
        // 0 and 1 both return 1
        else if (n < 2) return 1;
        // recursive call eventually leads to factorial(1) which returns 1
        else return n * factorial(n-1);
    }
    
    // BONUS METHOD IF YOU DON'T LIKE RECURSION
    public static Integer factorial2(Integer n) {
        // check valid input
        if (n < 0) {
            System.debug('Invalid Input! Only Positive Integers Allowed!');
            return 0;
        }
        // 0 and 1 both return 1
        else if (n < 2) return 1;
        // valid Integer input greater than 1 
        // loop which contributes to a running product while decrementing n
        else {
            Integer product = 1;
            do {
                product *= n--;
            } while (n > 1);
            return product;
        }
    }
    
    public static List<Integer> rotateLeft(List<Integer> arr, Integer n) {
        for (Integer i = 0; i < n; i++) {
            arr.add(arr.remove(0));
        }
        return arr;
    }
    
    public static Boolean balancedBrackets(String brackets) {
         // any string of brackets with an odd number of elements is not balanced
        if ((math.mod(brackets.length(), 2) == 1) || (brackets.length() == 0)) return false;
        
        // represent brackets string as list of unicode integers
        List<Integer> charList = brackets.getChars();
        
        // initialize list to store how many opening and closing brackets of each type the program has come across
        // set each list value to 0
        List<Integer> counts = new Integer[6];
        for (Integer i = 0; i < counts.size(); i++) counts[i] = 0;
        
        // loop through brackets characters list from both ends
        for (Integer i = 0; i < (charList.size() / 2); i++) {
            // switch statement based on which character is being looked at
            // increment the count of how many characters of that kind have been seen so far
            //      if it's an opening bracket, make sure the corresponding bracket is a closing bracket of the appropriate type
            //      if it's a closing bracket, make sure we haven't seen more closing bracket's than opening brackets
            //          then make sure the corresponding bracket is of the appropriate type
            switch on charList[i] {
                when 40 {
                    counts[0]++;
                    if (charList[charList.size() - 1 - i] != 41) return false;
                }
                when 41 {
                    counts[1]++;
                    if (counts[1] > counts[0]) return false;
                    if (charList[charList.size() - 1 - i] != 40) return false;
                }
                when 91 {
                    counts[2]++;
                    if (charList[charList.size() - 1 - i] != 93) return false;
                }
                when 93 {
                    counts[3]++;
                    if (counts[3] > counts[2]) return false;
                    if (charList[charList.size() - 1 - i] != 91) return false;
                }
                when 123 {
                    counts[4]++;
                    if (charList[charList.size() - 1 - i] != 125) return false;
                }
                when 125 {
                    counts[5]++;
                    if (counts[5] > counts[4]) return false;
                    if (charList[charList.size() - 1 - i] != 123) return false;
                }
                // if the character is something other than a bracket, return false
                when else {
                    System.debug('ERROR: Non-bracket characters present.');
                    return false;
                }
            }
        }
        // if we can't find anything wrong with the brackets, they must be balanced
        return true;
    }
    
    public static void updateAccountSize() {
        List<Account> accountList = [SELECT ID, NumberOfEmployees, Size__c FROM Account];
        for (Account a : accountList) {
            if (a.NumberOfEmployees > 10000) a.Size__c = 'large';
            else if (a.NumberOfEmployees > 1000) a.Size__c = 'medium';
            else a.Size__c = 'small';
        }
        update accountList;
    }
    
    public static void updateCALeads() {
        List<Lead> leadList = [SELECT ID, State, Status, Description FROM Lead WHERE State='CA'];
        for (Lead l : leadList) {
            l.Status = 'Closed - Not Converted';
            l.Description = 'We are no longer doing business in California.';
        }
        update leadList;
    }
    
    public static void updateOpportunitiesPastClosedDate() {
        List<Opportunity> opportunityList = [SELECT ID, CloseDate, StageName FROM Opportunity WHERE CloseDate < TODAY AND StageName != 'Closed Won' AND StageName != 'Closed Lost'];
        for (Opportunity o : opportunityList) o.StageName = 'Closed Lost';
        update opportunityList;
    }
}