import Foundation
import SystemConfiguration

public class NetworkModel {
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }

    class func getRequest(theUrl: String, _ callback: @escaping (_ in: String) -> ()) {

        let url = URL(string: theUrl)!
        var request = URLRequest(url: url);
        // preset header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET";

        // Getting response for GET Method
        DispatchQueue.global(qos: .background).async { // run in background
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return // check for fundamental networking error
                }

                // Getting values from JSON Response
                let responseString = String(data: data, encoding: .utf8);
                DispatchQueue.main.async {
                    callback(responseString!); // update ui here
                }
                
            }
            task.resume()
        }
    }

    class func postRequest(theUrl: String, body: Any, _ callback: @escaping (_ in: String) -> ()) {
        let url = URL(string: theUrl)!
        var request = URLRequest(url: url);
        // preset header
        request.setValue("application/json", forHTTPHeaderField: "Accept");
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST";
        do {
            let jsonData = try JSONEncoder().encode(body as! Dictionary<String, String>); //encode to Json object
            request.httpBody = jsonData; // pass to the request body
        } catch {
            print("is not a valid json object");
            return // break the process bc data is invalid
        }
        DispatchQueue.global(qos: .background).async { // run in background
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return // check for fundamental networking error
                } // Getting values from JSON Response
                let responseString = String(data: data, encoding: .utf8)!; // jsondata to jsonString
                DispatchQueue.main.async {
                    callback(responseString); // update ui here
                }
            }
            task.resume()
        }
    }

    }

