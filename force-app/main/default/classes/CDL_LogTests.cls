public with sharing class CDL_LogTests {
    public static void test() {
        try {
            Account account = [SELECT Id FROM Account];
        } catch (Exception ex) {
            insert new Account(Name = 'doisss');
            CDL_Log.get().publish(ex);
        }
    }
}
