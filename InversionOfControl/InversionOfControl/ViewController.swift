//
//  ViewController.swift
//  InversionOfControl
//
//  Created by Toheed Jahan Khan on 27/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Approach -1
        Approach1()
//        Approach2()
    }
    
    func Approach1() {
        let webService = WebserviceFramework(baseURL: "https://xyz")
        webService.performRequest(endPath: "/allData", completion: { (data, error) in
            if let requestError = error {
                webService.showError(error: requestError, on: self.view)
            }
        })
    }
    
    func Approach2()  {
        
        let webService = WebserviceFramework2(baseURL: "https://xyz")
        func setupBinding() {
            let frameworkListener = WebserviceFrameworkListener(requestCompleted: { data in
                // Do something with the data
            }, presentingView: {
                return self.view
            })
        }
    }
}

