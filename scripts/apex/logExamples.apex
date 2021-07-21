CDL_Log.get().publish('This is a test');
CDL_Log.get().publish(new DMLException('hi from exception land'));

try {
    Account account = [SELECT Id FROM Account];
}
catch (Exception ex) {
    insert new Account(Name='doisss');
    CDL_Log.get().publish(ex);
}