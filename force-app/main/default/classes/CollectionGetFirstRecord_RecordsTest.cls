@isTest(seeAllData=false)
private class CollectionGetFirstRecord_RecordsTest {
    @isTest
    static void testGetFirstRecord_ReturnsFirstRecord() {
        // Create test accounts
        Account a1 = new Account(Name='First Account');
        Account a2 = new Account(Name='Second Account');
        insert new List<Account>{a1, a2};

        // Prepare request with records (SObject list)
        CollectionGetFirstRecord_Records.Request req = new CollectionGetFirstRecord_Records.Request();
        req.records = new List<SObject>{a1, a2};

        List<CollectionGetFirstRecord_Records.Request> requests = new List<CollectionGetFirstRecord_Records.Request>{req};

        Test.startTest();
        List<CollectionGetFirstRecord_Records.Response> responses = CollectionGetFirstRecord_Records.getFirstRecord(requests);
        Test.stopTest();

        System.assertEquals(1, responses.size(), 'Should return one response per request');
        System.assertNotEquals(null, responses[0].record, 'Record should not be null');

        Account returned = (Account) responses[0].record;
        System.assertEquals(a1.Id, returned.Id, 'Should return the first account inserted');
        System.assertEquals(a1.Name, returned.Name, 'Name should match the first account');
    }

    @isTest
    static void testGetFirstRecord_MixedSObjectTypesReturnsNullWithError() {
        // Create test records of different SObject types
        Account acc = new Account(Name='Test Account');
        insert acc;
        Contact con = new Contact(LastName='Test Contact', AccountId=acc.Id);
        insert con;

        CollectionGetFirstRecord_Records.Request req = new CollectionGetFirstRecord_Records.Request();
        req.records = new List<SObject>{ acc, con };

        List<CollectionGetFirstRecord_Records.Request> requests = new List<CollectionGetFirstRecord_Records.Request>{ req };

        Test.startTest();
        List<CollectionGetFirstRecord_Records.Response> responses = CollectionGetFirstRecord_Records.getFirstRecord(requests);
        Test.stopTest();

        System.assertEquals(1, responses.size(), 'Should return one response');
        System.assertEquals(null, responses[0].record, 'Mixed types should yield null record');
        System.assertNotEquals(null, responses[0].errorMessage, 'Mixed types should set an error message');
    }

    @isTest
    static void testGetFirstRecord_EmptyAndNullListsReturnNull() {
        // Empty list
        CollectionGetFirstRecord_Records.Request emptyReq = new CollectionGetFirstRecord_Records.Request();
        emptyReq.records = new List<SObject>();

        // Null list
        CollectionGetFirstRecord_Records.Request nullReq = new CollectionGetFirstRecord_Records.Request();
        nullReq.records = null;

        List<CollectionGetFirstRecord_Records.Request> requests = new List<CollectionGetFirstRecord_Records.Request>{emptyReq, nullReq};

        Test.startTest();
        List<CollectionGetFirstRecord_Records.Response> responses = CollectionGetFirstRecord_Records.getFirstRecord(requests);
        Test.stopTest();

        System.assertEquals(2, responses.size(), 'Should return two responses');
        System.assertEquals(null, responses[0].record, 'Empty list should yield null record');
        System.assertEquals(null, responses[1].record, 'Null list should yield null record');
    }
}