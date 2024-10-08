/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Judy Heljeberg
*/

public with sharing class SOQL {
    
      /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    public static List<Lead> getAllLeads() {
        //  The body of the method
        return [SELECT Id, LastName, Company, Phone, Email FROM Lead];
        }
//}

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters)
    public static List<Contact> getContactsByFirstName(String firstName) {
   
    //  The body of the method
        return [SELECT Id, FirstName, LastName, Name FROM Contact WHERE FirstName = :firstName];
        }
//}

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters)
    public static List<Id> getContactIdsByLastName(Set<String> lastNames) {

    //  The body of the method
        List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName IN :lastNames];
        List<Id> contactIds = new List<Id>();
        for (Contact contact : contacts) {
            contactIds.add(contact.Id);
    }  
        return contactIds;
        }
//}

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters)
    public static List<Opportunity> getClosedWonOpportunitiesByAccount(Id accountId) {
    //  The body of the method
    return [SELECT Id, Name, StageName, CloseDate, Amount, AccountId 
    FROM Opportunity 
    WHERE AccountId = :accountId 
    AND StageName = 'Closed Won'];
        }  
//}

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters)
    public static Integer getAccountCount() {
    //  The body of the method
    return [SELECT COUNT() FROM Account];
        }
//}

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters)
    public static Map<Id, Task> getTasksDueNextWeek() {
    //  The body of the method
    Date nextWeek = Date.today().addDays(7);
    List<Task> tasks = [SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate <= :nextWeek AND ActivityDate >= TODAY ORDER BY ActivityDate];
    Map<Id, Task> taskMap = new Map<Id, Task>();
    for (Task task : tasks) {
        taskMap.put(task.Id, task);
    }
    return taskMap;
        }
//}

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters)
    public static List<Contact> getContactsByEmailDomain(String emailDomain) {
    //  The body of the method
    return [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email LIKE :emailDomain];
        }
//}

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        if (keyword == null || keyword.trim() == '') {
            return new List<Opportunity>();
        }
        return [SELECT Id, Name, StageName, CloseDate, AccountId FROM Opportunity WHERE Name LIKE : '%' + keyword + '%'];
    } // Replace null with the variable you used to store the result
    

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        //return  [SELECT Id, Status, AccountId, Origin FROM Case WHERE Origin != null AND Origin != ''];
    //}// Replace null with the variable you used to store the result
    
    return [
        SELECT Id, Status, AccountId, Origin
        FROM Case
        WHERE Origin != 'Web' AND Origin != 'Email' AND Origin != null AND Origin != ''
    ];
}
    
     /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters)
    public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword) {
    //  The body of the method
    return [
            SELECT Id, LastName, Company, Phone, Email, LeadSource, Title
            FROM Lead
            WHERE LeadSource = :leadSource OR Title LIKE :('%' + keyword + '%')
        ];
    }
    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> contactLastNames = new List<String>();
        // Query the Contacts
        List<Contact> contacts = [
            SELECT LastName
            FROM Contact
            WHERE AccountId = :accountId
        ];
        // Loop through each Contact and add the LastName to the list
        for (Contact contact : contacts) {
            contactLastNames.add(contact.LastName);
        }
  
        // Return the list of Contact LastNames
        return contactLastNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        AggregateResult[] groupedResults = [
            SELECT SUM(Amount) totalRevenue
            FROM Opportunity
            WHERE StageName = :stage 
        ];
        Decimal totalRevenue = (Decimal)groupedResults[0].get('totalRevenue');
        // Return the total revenue
        return totalRevenue != null ? totalRevenue : 0; // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        return [SELECT Id, Name FROM Account ORDER BY Name LIMIT 10]; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        return [SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5]; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        return [SELECT Id, FirstName, LastName, Birthdate
        FROM Contact
        WHERE Birthdate != null
        ORDER BY Birthdate DESC
        LIMIT 3]; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        return [SELECT Id, Subject, Status, CreatedDate 
        FROM Case
        WHERE Status = 'Open'
        ORDER BY CreatedDate
        LIMIT 10 OFFSET 5]; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseIds = new Set<Id>();
        // Query the Cases
        List<Case> cases = [SELECT Id FROM Case WHERE AccountId = :accountId];
        // Loop through each Case and add the Id to the set
        for (Case cs : cases) {
            caseIds.add(cs.Id);
        }
        return caseIds; // Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE BillingCountry != :country];
        // Loop through each Account and add the Id and Name to the map
        for (Account acc : accounts) {
            accountIdsToNames.put(acc.Id, acc.Name);
        }
        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        String accountName = null;
        Contact contact = [SELECT Account.Name FROM Contact WHERE Id = :contactId LIMIT 1];
        if (contact != null && contact.Account != null) {
            accountName = contact.Account.Name;
        }
        return accountName; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        Account accountWithOpps = [SELECT Id, Name,
                                        (SELECT Id, Name, Amount, CloseDate FROM Opportunities)
                                    FROM Account
                                    WHERE Id = :accountId
                                    LIMIT 1];
        return accountWithOpps; // Replace null with the variable you used to store the result
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        List<Contact> matchingContacts = new List<Contact>();
        // Query the Account
        Account acc = [SELECT BillingState FROM Account WHERE Id = :accountId LIMIT 1];
       
        // Store the Account's BillingState
        String billingState = acc.BillingState;

        // Query the Contacts
        matchingContacts = [SELECT Id, FirstName, LastName, MailingState 
                            FROM Contact 
                            WHERE MailingState = :billingState];
        return matchingContacts; // Replace null with the variable you used to store the result
    }

/**
* Question 22
* Extracts email domains from them leads, then finds Accounts with matching website domains
* If Lead Email = test@test.com return account with website = www.test.com
* Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
* @param A set of Lead Ids.
* @return A list of Accounts with matching email domains.
*/
public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        
    Set<String> emailDomains = new Set<String>();
    for (Lead lead : [SELECT Id,company, Email FROM Lead WHERE Id IN:leadIds]) 
    {
        // Get the email from the Lead
        String email = lead.Email;
        
        // Check if the email is not null
        if (email != null) 
        {
            //system.debug('this is email when not null => '+email);//this is email when not null => bertha@fcof.net
            String emailDomain = email.split('@') [1];//this is emailDomain from email => fcof.net
            //system.debug('this is emailDomain from email => '+emailDomain);
            
            // Find the last dot in the domain to remove the TLD
            Integer lastDotIndex = emailDomain.lastIndexOf('.');
            if (lastDotIndex > 0) 
            {
                //return emailDomain.substring(0, lastDotIndex);
                emailDomains.add (emailDomain.substring(0, lastDotIndex));
            }
            
            system.debug('this is emailDomains from email => '+emailDomains);
        }
    }
    
    // Convert the set of email domains to a list
    List<String> emailDomainList = new List<String>(emailDomains);
    
    // Build the dynamic SOQL query
    String query = 'SELECT Id, Name, Website FROM Account WHERE ';
    
    // Add conditions for each domain
    List<String> conditions = new List<String>();
    for (String domain : emailDomainList) {
        conditions.add('Website LIKE \'%' + domain + '%\'');
    }
    
    // Join the conditions with 'OR'
    query += String.join(conditions, ' OR ');
    system.debug('this is query => '+query);
    // Execute the query
    List<Account> matchingAccounts = Database.query(query);
    
    // Debug the matching accounts
    system.debug('Matching Accounts: ' + matchingAccounts);
    
    return matchingAccounts;

}


     /**
* Question 23
* Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
* Adds a randomized number between 1 to 3 to the quantity of each line item.
* Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
* @param Original Opportunity Id
* @param List of cloned Opportunity Ids
*/
public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
    // Query for the line items related to the source opportunity
    List<OpportunityLineItem> sourceLineItems = [
        SELECT Quantity, PricebookEntryId, UnitPrice
        FROM OpportunityLineItem
        WHERE OpportunityId = :origOppId
    ];

    // Prepare a list to hold the cloned line items for bulk insertion
    List<OpportunityLineItem> clonedLineItems = new List<OpportunityLineItem>();

    // Loop through each target opportunity Id
    for (Id targetOpportunityId : cloneOppIds) {
        // For each source line item, create a clone for the target opportunity
        for (OpportunityLineItem sourceItem : sourceLineItems) {
            OpportunityLineItem clonedItem = sourceItem.clone(false, true); // shallow clone, preserve read-only fields
            clonedItem.OpportunityId = targetOpportunityId; // Set the target opportunity Id
            clonedLineItems.add(clonedItem); // Add to the list for bulk insertion
        }
    }

    // Insert the cloned line items in bulk
    if (!clonedLineItems.isEmpty()) {
        insert clonedLineItems;
    }
} 
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {  
        List<Opportunity> closedWonOpportunities = [ 
            SELECT Id, Name, Account.Name, Owner.Name
            FROM Opportunity
            WHERE StageName = 'Closed Won'
        ];     
        return closedWonOpportunities; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
     
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> closedWonOpportunities = getOpportunityDetailsForClosedWon();
        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : closedWonOpportunities) {
            if (opp.AccountId != null) {
                accountIds.add (opp.AccountId );
            }
        }
        
        List<Contact> contacts = new List<Contact>();

        // Query the Contacts
        if (!accountIds.isEmpty()) {
            contacts = [
                SELECT Id, AccountId
                FROM Contact
                WHERE AccountId IN :accountIds
            ];
        }

        // Loop through each Contact and add the Account Id and Contact to the map
        Map<Id,Contact> accountToContactMap = new Map<Id,Contact> ();
        for (Contact contact : contacts) {
            if (!accountToContactMap.containsKey(contact.AccountId)){
                accountToContactMap.put(contact.AccountId, contact);
            }
        }
        
         // Loop through each Opportunity
         List<Opportunity> oppsToUpdate = new List<Opportunity>();
         for (Opportunity opp: closedWonOpportunities) {
 
           // Update the Opportunity primary contact from accountToContactMap
             if (accountToContactMap.containsKey(opp.AccountId)) {
                 opp.Primary_Contact__c=accountToContactMap.get(opp.AccountId).Id;
                 oppsToUpdate.add(opp);
             }
         }
 
         // Update the Opportunities
             if (!oppsToUpdate.isEmpty()){
                 update oppsToUpdate;
             }          
     }
       
}
