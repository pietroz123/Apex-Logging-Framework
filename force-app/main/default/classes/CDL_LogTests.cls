@IsTest
private class CDL_LogTests {
    @IsTest
    static void testLog() {
        Test.startTest();
        CDL_Log.get().publish('This is a test');
        CDL_Log.get().publish(new DMLException('hi from exception land'));
        Test.stopTest();

        Test.getEventBus().deliver();

        List<CDL_Custom_Debug_Log__c> newLogs = [
            SELECT Id
            FROM CDL_Custom_Debug_Log__c
        ];
        System.assertEquals(
            2,
            newLogs.size(),
            'expected to find two created logs'
        );
    }

    @isTest
    static void testLogMultiple() {
        CDL_Log logger = CDL_Log.get();
        Test.startTest();
        logger.add('testing add string method');
        logger.add('Testing 123', CDL_LogSeverity.WARN);
        logger.add(new DMLException('hi from exception land'));
        logger.add(new DMLException('meh'), CDL_LogSeverity.DEBUG);
        logger.publish();
        Test.stopTest();

        // Platform Events require this to push the event in a test env
        Test.getEventBus().deliver();

        List<CDL_Custom_Debug_Log__c> newLogs = [
            SELECT Id
            FROM CDL_Custom_Debug_Log__c
        ];
        System.assertEquals(
            4,
            newLogs.size(),
            'expected to find four created logs'
        );
    }
}
