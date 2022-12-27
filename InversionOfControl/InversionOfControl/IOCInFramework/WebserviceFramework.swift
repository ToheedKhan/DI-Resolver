//
//  WebserviceFramework.swift
//  InversionOfControl
//
//  Created by Toheed Jahan Khan on 27/12/22.
//

import UIKit

public class WebserviceFramework {
    let baseURL: String
    
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    public func performRequest(endPath: String, completion: @escaping (Data?, Error?)->()) {
        // Perform the webservice and return back the error or resonse
        URLSession.shared.dataTask(with: URL(string: baseURL+endPath)!) { (data, response, error) in
            completion(data, error)
        }
    }
    
    public func showError(error: Error, on: UIView) {
        // Show alert and pass the control back to the callee
    }
    
    public func userAcknowledgedAlert() {
        // Disimiss the alert on acknowledgement
    }
    
}


/*
 The consumer of the WebserviceFramework now controls the flow of events when it says:

 performRequest to perform web service calls.
 URLSession is an iOS framework to perform network requests to a server.
 Upon receiving the completion from the framework, the program now analyses the result and again calls the framework to handle the errors.
 The framework displays an alert to the user regarding the error and upon acknowledgment, your code calls the framework again to dismiss the error alert.
 This approach has the following caveats:

 You can not easily replace the framework with any other framework which does not have a similar API to avoid minimal changes.
 Learning the framework for any new user would be difficult because the methods needed to perform the functionalities of this framework will be huge.
 Debugging the program flow will be difficult based on how the user program calls the framework APIs.
 These types of frameworks are known as white-box frameworks.
 */
