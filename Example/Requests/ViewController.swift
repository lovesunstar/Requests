//
//  ViewController.swift
//  Network
//
//  Created by Suen on 05/24/2016.
//  Copyright (c) 2016 Suen. All rights reserved.
//

import UIKit
import Requests
import Alamofire

class NetworkClient: NSObject, NetworkClientProtocol {
    
    static var commonParametersSorter: ((String, String) -> Bool)? {
        return nil
    }
    
    static var timeoutInterval: TimeInterval {
        return 15.0
    }

    static var commonParameters: [String: Any]? {
        var results = [String: Any]()
        results["client_timestamp"] = Date().timeIntervalSince1970
        results["request_id"] = UUID().uuidString
        return results
    }
    
    static var requestHeaders: [String: String]? {
        return ["X-Session-ID": "11", "Accept": "application/json"]
    }
    
    static var isGZipEnabled: Bool {
        return true
    }
    
    static func compressBodyUsingGZip(_ data: inout Data) -> Bool {
        return false
    }
    
    static func preprocessRequestBody(_ data: inout Data, mark: [String : Any]?, additionalHeaders: inout [String : String]) -> Bool {
        return false
    }
    
    static func preprocessResponseBody(_ data: inout Data, response: URLResponse?) -> Bool {
        return false
    }
    
    static func willProcessRequest(_ URLString: inout String, headers: inout [String : String], parameters: inout [String : Any]?) {
        
    }
    
    static func willProcessResponse(_ request: URLRequest, totalDuration: TimeInterval, responseData: Any?, error: Error?, urlResponse: HTTPURLResponse?, metrics: URLSessionTaskMetrics?) {
    }
    
    static func serverTrustEvaluator(forHost host: String) -> ServerTrustEvaluating? {
        if host == "45.40.61.50" {
//            return DefaultTrustEvaluator(validateHost: false)
        }
        return nil
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let request = Requests.request("https://api.pokekara123123.com/get").query(["foo": "bar"]).retry(2).build()
        
        request?.responseJSON(completionHandler: { (_, urlResponse, jsonData, error) -> Void in
            print("Request3", urlResponse ?? "", jsonData ?? "", error ?? "")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

