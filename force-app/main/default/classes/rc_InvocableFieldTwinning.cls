public with sharing class rc_InvocableFieldTwinning {
    @InvocableMethod (label='Twin Opportunity to Quote' description='Twin Fields from Non-Twinnable Objects' category = 'Revenue Cloud Accelerators')
    public static void setTwinFields(List<Request> requests){
        
        List<SObject> recsToUpdate = new List<SObject>();
        
        for(Request r:requests){
            system.debug(r.twinFields);
            SObject source = (SObject)r.opportunityObject;
            SObject destination = (SObject)r.quoteObject;

            for(String fieldName:r.twinFields){   
                destination.put(fieldName,source.get(fieldName));
            }

            recsToUpdate.add(destination);
        }
        update recsToUpdate;
    }

    public class Request{
        @InvocableVariable
        public String sourceObjectName;

        @InvocableVariable
        public String destinationObjectName;
        
        @InvocableVariable
        public Opportunity opportunityObject;

        @InvocableVariable
        public SBQQ__Quote__c quoteObject;

        @InvocableVariable
        public List<String> twinFields;
    }
}