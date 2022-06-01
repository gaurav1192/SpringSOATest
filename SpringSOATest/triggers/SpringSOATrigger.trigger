trigger SpringSOATrigger on Contact (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            SpringSOATriggerHandler.afterInsert(Trigger.new);
        }
        if(Trigger.isUpdate) {
            SpringSOATriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
        if(Trigger.isDelete) {
            SpringSOATriggerHandler.afterDelete(Trigger.old);
        }
        if(Trigger.isUndelete) {
            SpringSOATriggerHandler.afterUndelete(Trigger.new);
        }
    }
}