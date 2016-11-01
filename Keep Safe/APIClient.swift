//
//  APIClient.swift
//  Keep Safe
//
//  Created by Mert Serin on 01/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import Foundation
import Alamofire


class APIClient{
    
    
    
    
    func register(email:String, password:String, completion:((fieldError:String, error:NSError?)->Void)?){
        let parameters = [
            "email":email,
            "password":password]
        
        Alamofire.request(Router.register(parameters)).responseJSON{response in
            print(response)
            print(response.result.value)
            if let jsonresult:NSDictionary = response.result.value as? NSDictionary{
                print("girdim1")
                if let result:Bool = jsonresult["result"] as! Bool{
                    print("girdim2")
                    if(result == true){
                        print("girdim3")
                        completion!(fieldError: "",error: nil)
                    }
                    else{
                        print("girdim4")
                        completion!(fieldError: "0",error: nil)
                    }
                }
            
                
            }
            else{
                print("girdim5")
                completion!(fieldError: "",error: response.result.error)
            }
        }
        
    }
    
    
    
    
    // MARK: - Router
    enum Router: URLRequestConvertible {
        
        static let baseURL = Constants.baseURL
        
        case register([String: String])
        
        
        var method: Alamofire.Method {
            switch self {
            case .register:
                return .GET
            default:
                return .GET
            }
        }
        
        // MARK: URLStringConvertible
        var path: String {
            switch self {
            case .register:
                return Constants.registerURL
            default:
                return ""
            }
        }
        
        // MARK: URLRequestConvertible
        var URLRequest: NSMutableURLRequest {
            let URL = NSURL(string: Router.baseURL)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path)!)
            mutableURLRequest.HTTPMethod = method.rawValue
            
            
            switch self {
            case .register(let parameters):
                print(parameters)
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
            default:
                return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0
            }
            
        }
    }
    
}
