### Apex Logging Framework

**This is a project based on a video from the CodeLive series from Salesforce Developers' Youtube Channel ([see it here](https://www.youtube.com/watch?v=m5l7PkaG6h0&ab_channel=SalesforceDevelopers)).**

The purpose of this framework is to help developers to know what's wrong with their code, by using platform events and custom objects. Seeing logs through the Salesforce UI such as any other normal record is much more friendly than looking through the haystack that is the logs in Developer Console.

To achieve this, one Platform Event (Log Event) and one Custom Object (Custom Debug Log) were created. When the user publishes a Log Event, a trigger (CDL_LogTrigger) creates a Custom Debug Log record. But why use a Platform Event **and** a Custom Object, you may ask?

Suppose a developer creates the following code on the controller of a component (Aura or LWC), and suppose that someone already created a custom object for logging errors.

```java
try {
    Account account = [SELECT Id FROM Account];
}
catch (Exception ex) {
    Database.insert(new Log(Message__c=ex.getMessage()));
    throw ex;
}
```

The problem with this code is that when the exception is thrown, all DML operations executed before the exception are rolled back, and thus no log is inserted. This is where a platform event for logging helps us. By using a platform event, we can create a secondary execution context that allows the event to be created, and because we are in another context, the trigger runs and creates the log based on the event.

> Obs: This requires the platform event to have a Behavior of "Publish Immediately"

Using the framework, the code above would be like this:

```java
try {
    Account account = [SELECT Id FROM Account];
}
catch (Exception ex) {
    CDL_Log.get().publish(ex);
    throw ex;
}
```

### Examples

**1. Publish Single Logs**

```java
CDL_Log.get().publish('This is a test');
CDL_Log.get().publish(new DMLException('hi from exception land'));
```

**2. Publish Multiple Logs**

```java
CDL_Log logger = CDL_Log.get();
logger.add('testing add string method');
logger.add('Testing 123', CDL_LogSeverity.WARN);
logger.add(new DMLException('hi from exception land'));
logger.add(new DMLException('meh'), CDL_LogSeverity.DEBUG);
logger.publish();
```

### Overview

**Log Event and Custom Debug Log**
- Request Id
- Quiddity
- Error Message
- Stack Trace
- Line Number
- Severity
- Exception Type

**Reports**
- Logs Overview
- Logs by Type
- Logs by Quiddity
- Logs by Severity

**Dashboards**
- Logs Overview

**Apps**
- Logs Control Panel