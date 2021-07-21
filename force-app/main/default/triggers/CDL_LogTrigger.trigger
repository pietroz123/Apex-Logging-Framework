trigger CDL_LogTrigger on CDL_Log_Event__e(after insert) {
    /**
     * After publishing a log event, we need to store it on the custom object
     */
    if (Trigger.isAfter && Trigger.isInsert) {
        List<CDL_Custom_Debug_Log__c> newLogs = new List<CDL_Custom_Debug_Log__c>();

        for (CDL_Log_Event__e eventLog : Trigger.new) {
            newLogs.add(
                new CDL_Custom_Debug_Log__c(
                    CDL_Message__c = eventLog.CDL_Message__c,
                    CDL_Quiddity__c = eventLog.CDL_Quiddity__c,
                    CDL_Request_Id__c = eventLog.CDL_Request_Id__c,
                    CDL_Severity__c = eventLog.CDL_Severity__c,
                    CDL_Stack_Trace__c = eventLog.CDL_Stack_Trace__c,
                    CDL_Line_Number__c = eventLog.CDL_Line_Number__c,
                    CDL_Type__c = eventLog.CDL_Type__c
                )
            );
        }

        Database.insert(newLogs);
    }
}
