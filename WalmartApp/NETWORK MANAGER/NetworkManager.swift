//
//  NetworkManager.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import Foundation

enum Method: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkManager{
    
    static let shared = NetworkManager()
    let urlSession = URLSession.shared
    
    //Request method to fetch the data from API based on the requested baseURL and endpoint + parameters.
    func request(baseURL: String, endpoint: String, method: Method = .GET, parameters: NSDictionary, completion: ((Data?,  Error?,_ response:HTTPURLResponse) -> ())?){
        if(reachable()){
            let url =  baseURL + endpoint
            var urlRequest = URLRequest(url: URL(string: url)! as URL)
            switch method {
                case .GET:
                    urlRequest = self.getRequest(url, parameters: parameters)
                default:
                    break
            }
           // urlRequest.addValue(APIConstants.APPLN_JSON, forHTTPHeaderField: "Accept")
            let task = urlSession.dataTask(with: urlRequest) {
                (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if (data == nil || error != nil) {
                        if response == nil {
                            completion?(nil, error, HTTPURLResponse.init())
                        }else{
                            completion?(nil, error, response as? HTTPURLResponse ?? HTTPURLResponse())
                        }
                    } else {
                        completion?(data, error, response as? HTTPURLResponse ?? HTTPURLResponse())
                    }
                }
            }
            task.resume()
        }else{
            print("No Network Connection")
        }
    }
    
    //MARK: Private functions to handle network calls
    //Create get request with the parameters as query parameters if available
    private func getRequest(_ urlString: String, parameters:NSDictionary?) -> URLRequest{
        var finalURL:String = String.emptyString
        if let params = parameters{
            let queryString = self.queryString(params)
            finalURL =  urlString + "/" + queryString
        }else{
            finalURL = urlString
        }
        print("%%%%%%%%%")
        print(finalURL)
        
        var request = URLRequest(url: URL(string: finalURL)! as URL)
        request.httpMethod = "GET"
        return request
    }
    
    //Create query string for GET request based on parameters
    private func queryString(_ parameters: NSDictionary) -> String {
        var urlVars = [String]()
        for (_, val) in parameters {
            urlVars += ["\(val)"]
        }
        return urlVars.joined(separator: "/")
    }
    
    //Checking for the Reachability
    private func reachable() -> Bool{
        let reachability = Reachability()
        if reachability?.currentReachabilityStatus == Reachability.NetworkStatus.notReachable{
            return false
        }
        return true
    }
    
}
