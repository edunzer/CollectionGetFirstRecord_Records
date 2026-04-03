public with sharing class CollectionGetFirstRecord_Records {
    @InvocableMethod(label='Get First Record from Record Collection' description='Returns the first full record from a list of records.')
    public static List<Response> getFirstRecord(List<Request> requests) {
        List<Response> results = new List<Response>();

        for (Request req : requests) {
            Response resp = new Response();

            if (req.records == null) {
                resp.record = null;
                resp.errorMessage = 'Input list was null';
                results.add(resp);
                continue;
            }

            if (req.records.isEmpty()) {
                resp.record = null;
                resp.errorMessage = 'Input list was empty';
                results.add(resp);
                continue;
            }

            resp.record = req.records[0];
            results.add(resp);
        }

        return results;
    }

    public class Request {
        @InvocableVariable(label='Records' description='List of records to search; the first record will be returned.' required=true)
        public List<SObject> records;
    }

    public class Response {
        @InvocableVariable(label='Record' description='The first record from the provided collection')
        public SObject record;
        @InvocableVariable(label='Error Message' description='Description of why no record was returned, when applicable')
        public String errorMessage;
    }
}