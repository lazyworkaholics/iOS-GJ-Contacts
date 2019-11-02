//
//  NetworkManager.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
import Reachability

enum HTTPRequestType:String {
    case GET
    case POST
    case PUT
    case DELETE
}

class NetworkManager
{
    static let sharedInstance = NetworkManager()
    var urlSession : URLSession
    var reachability : Reachability
    
    init() {
        let defaultConfiguration = URLSessionConfiguration.default
        self.urlSession = URLSession.init(configuration: defaultConfiguration)
        self.reachability = Reachability.forInternetConnection()
    }
    
    // http request function that handles the core networking with backend server
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String: String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void) {
        
        // check if the device has internet connectivity, either through wifi or cellular
        if reachability.isReachableViaWiFi() == false &&
            reachability.isReachableViaWWAN() == false
        {
            let errorObject = self.errorObjectFromString("No network connection detected", errorCode: Network_Error_Constants.NOT_REACHABLE)
            failureBlock(errorObject)
            return
        }
        
        // check if a valid urlRequest be constructed out of the given input fields
        guard let urlRequest = self.requestConstructor(urlPath, params: params, method: method, headers: headers, body: body) else {
            return
        }
        
        self.sessionDataTask(urlRequest, onSuccess: successBlock, onFailure: failureBlock)
        
    }
    
    // MARK: -
    // core function to handle urlSession's dataTask
    // calls and validates the network response
    // with appropriate success and failure blocks
    private func sessionDataTask(_ urlRequest:URLRequest,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
    {
        // urlsession's dataTask function call to fetch response from backent
        let dataTask = urlSession.dataTask(with: urlRequest) {
            (responseData, urlResponse, error) in
            
            if error == nil
            {
                if let urlResponse = urlResponse as? HTTPURLResponse
                {
                    //The API call was successful, go ahead and parse the data
                    if urlResponse.statusCode >= 200 && urlResponse.statusCode <= 206
                    {
                        if let responseData = responseData
                        {
                            successBlock(responseData)
                        }
                        else
                        {
                            //Oops we should never get here in the first place. Abort!
                            let errorObject = self.errorObjectFromString("Cannot parse the response", errorCode: Network_Error_Constants.PARSING_ERROR)
                            failureBlock(errorObject)
                        }
                    }
                    else
                    {
                        let localizedErrorString = HTTPURLResponse.localizedString(forStatusCode: urlResponse.statusCode)
                        let errorObject = self.errorObjectFromString(localizedErrorString,
                                                                     errorCode: urlResponse.statusCode)
                        failureBlock(errorObject)
                    }
                }
                else
                {
                    //Oops we should never get here in the first place. Abort!
                    let errorObject = self.errorObjectFromString("Cannot parse the response", errorCode: Network_Error_Constants.PARSING_ERROR)
                    failureBlock(errorObject)
                }
            }
            else
            {
                let errorObject = self.errorObjectFromString(error!.localizedDescription, errorCode: Network_Error_Constants.URLSESSION_ERROR)
                failureBlock(errorObject)
            }
        }
        dataTask.resume()
    }
    
    // helper function to construct a urlRequest from given relative path, parameters, body etc
    private func requestConstructor(_ urlPath:String,
                            params: [String: String]?,
                            method: HTTPRequestType,
                            headers: [String: String]?,
                            body: Data?) -> URLRequest?
    {
        guard var url = URL.init(string: Network_Constants.BASE_URL) else {
            return nil
        }
        
        var relativePath = urlPath
        if params != nil
        {
            relativePath = relativePath + "?"
            var isFirstIteration:Bool = true
            for (key, value) in params ?? [:] {
                if !isFirstIteration {
                    relativePath = relativePath + "&"
                    isFirstIteration = false
                }
                relativePath = relativePath + key + "=" + value
            }
        }
        
        url.appendPathComponent(relativePath)
        
        var urlRequest = URLRequest.init(url:url,
                                         cachePolicy: .useProtocolCachePolicy,
                                         timeoutInterval:60.0)
        urlRequest.httpMethod = method.rawValue
        
        if body != nil
        {
            urlRequest.httpBody = body
        }
        
        for (key, value) in headers ?? [:] {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    // helper function to construct an Error object from Error String and Error Code
    private func errorObjectFromString(_ errorString:String, errorCode:Int) -> NSError
    {
        let error = NSError.init(domain: Network_Error_Constants.ERROR_DOMAIN,
                                 code: errorCode,
                                 userInfo: [NSLocalizedDescriptionKey:errorString])
        
        return error
    }
}
