import ballerina/http;

type Operations record {|

    
|};
service / on new http:Listener(9090) {

    resource function post resetPassword(string user, string newPassword) returns json|error {
     http:Client ISClient = check new ("localhost:9443",
        auth = {
            username: "admin",
            password: "admin"
        },
        secureSocket = {
            cert: "/home/amila/Desktop/IsCertificate.cer"
        }
    );
      json|http:ClientError payload = ISClient->/scim2/Users/[user].patch({
        Operations:[{op:"replace",value:{password:newPassword}}],
        schemas:["urn:ietf:params:scim:api:messages:2.0:PatchOp"]
        },
        {
            "Content-Type": "application/scim+json" ,
            "Accept": "application/scim+json"
        });
      return payload;
    }
    
}