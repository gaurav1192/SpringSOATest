public class SprigSOACallout {
    public static void doCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> foobarMap = (Map<String, Object>) results.get('args');
            
            for(String arg: foobarMap.keySet()) {
                System.debug(foobarMap.get(arg));
            }
        }
    }
}