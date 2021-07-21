/**
 * @description A class for automatically attaching metadata to log messages
 * like Quiddity and RequestID
 *
 * @group Shared Code
 *
 */
public with sharing class CDL_LogMessage {
    /**
     * @description public read only property for the request ID. Privately set.
     */
    public String requestId {
        get {
            if (requestId == null) {
                requestId = Request.getCurrent().getRequestId();
            }
            return requestId;
        }
        private set;
    }

    /**
     * @description Public read only property for quiddity. Privately set.
     */
    public Quiddity quiddity {
        get {
            if (quiddity == null) {
                quiddity = Request.getCurrent().getQuiddity();
            }
            return quiddity;
        }
        private set;
    }

    /**
     * @description Other properties.
     */
    public String message { get; set; }
    public String stackTrace { get; set; }
    public CDL_LogSeverity severity { get; set; }
    public Integer lineNumber { get; set; }
    public String type { get; set; }

    /**
     * @description   Constructor accepting a message to log.
     * Severity is auto set to info
     * @param message
     */
    public CDL_LogMessage(String message) {
        this.message = message;
        this.severity = CDL_LogSeverity.INFO;
    }

    /**
     * @description Constructor accepting an exception object.
     * @param ex
     */
    public CDL_LogMessage(Exception ex) {
        this.message = ex.getMessage();
        this.stackTrace = ex.getStackTraceString();
        this.lineNumber = ex.getLineNumber();
        this.type = ex.getTypeName();
        this.severity = CDL_LogSeverity.ERROR;
    }

    /**
     * @description converts this object to an event for publishing
     * @return      `SObject`
     */
    public CDL_Log_Event__e toEvent() {
        return new CDL_Log_Event__e(
            CDL_Request_Id__c = this.requestId,
            CDL_Quiddity__c = this.quiddity?.name(),
            CDL_Message__c = this.message,
            CDL_Stack_Trace__c = this.stackTrace,
            CDL_Line_Number__c = this.lineNumber,
            CDL_Type__c = this.type,
            CDL_Severity__c = this.severity?.name()
        );
    }
}
