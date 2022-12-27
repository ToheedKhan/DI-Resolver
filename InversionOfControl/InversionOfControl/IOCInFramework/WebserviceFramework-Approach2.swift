//
//  WebserviceFramework-Approach2.swift
//  InversionOfControl
//
//  Created by Toheed Jahan Khan on 27/12/22.
//

import UIKit

struct WebserviceFrameworkListener {
    let requestCompleted: (Data?) -> Void
    let presentingView: () -> UIView
}

public class WebserviceFramework2 {
    let baseURL: String
    var listnener: WebserviceFrameworkListener?
    
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func performRequest(endPath: String) {
        // Perform the webservice and handle the response accordingly
        URLSession.shared.dataTask(with: URL(string: baseURL+endPath)!) { [weak self] (data, response, error) in
            if let requestError = error {
                self?.showError2(error: requestError)
            } else {
                 self?.listnener?.requestCompleted(data)
            }
        }
    }
    
    private func showError2(error: Error) {
        let viewToPresentAlert = self.listnener?.presentingView()
        // Show alert
    }
    
    private func userAcknowledgedAlert() {
        // Disimiss the alert on acknowledgement
        self.listnener?.requestCompleted(nil)
    }
}

/*
 With this approach, your framework performs the same network request but controls the error handling mechanism internally. Your code still passes all the required configurations such as a view to present the alert on and a completion callback to the framework via the setUpBinding() to the framework. These are known as black-box frameworks.
 */
