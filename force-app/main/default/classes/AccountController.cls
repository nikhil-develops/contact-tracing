public class AccountController {
    public static void updateAvgCaseResolutionDays(List<Id> accountIds) {
        Integer totalDays = 0, totalCases = 0;
        
        // Retrieve all the accounts on the basis of Account Ids
        // Get resolution days for each account (ClosedDate - CreatedDate)
        List<Account> allAcc = [SELECT Id, Avg_Case_Resolution_Days__c,
                                (SELECT Id, CreatedDate, ClosedDate
                                 FROM Cases
                                 WHERE IsClosed = true)
                                FROM Account WHERE Id IN :accountIds];
                                
        for (Account acc : allAcc) {
            for (Case caseObj : acc.Cases) { 
                // Increase number of cases
                totalCases++;
                
                // Get duration in days and add it to totalDays
                totalDays += caseObj.ClosedDate.date().daysBetween(caseObj.CreatedDate.date());
            }
              
            if (totalCases > 0) {
                acc.Avg_Case_Resolution_Days__c = (Decimal) totalDays / totalCases;
            } else {
                acc.Avg_Case_Resolution_Days__c = 0;
            }
            
            // Reset totals for the next account
            totalCases = 0;
            totalDays = 0;
        }
        
        // Update account object
        update allAcc;
    }
}