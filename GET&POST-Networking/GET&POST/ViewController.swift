//
//  ViewController.swift
//  GET&POST
//
//  Created by Sai Naveen Katla on 28/09/20.
//  Copyright © 2020 Sai Naveen Katla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - GET

    @IBAction func getTapped(_ sender: Any) {
        //create url
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users") {
            //create a session
            let session = URLSession.shared
            //assign session a task
            session.dataTask(with: url) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if error == nil {
                    if let safedata = data {
                        do {
                            //get data
                            try print(JSONSerialization.jsonObject(with: safedata, options: []))
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }.resume()
        }
    }
    
    //MARK: - POST
    
    @IBAction func postTapped(_ sender: Any) {
        //create parameters to pass
        let parameters = ["name": "katlasainaveen", "text": "Hello World!"]
        //create a url
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            }
            catch {
                print(error)
            }
            
            //create a session
            let session = URLSession.shared
            //assign session a task
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if error == nil {
                    if let safedata = data {
                        do {
                            //data
                            try print(JSONSerialization.jsonObject(with: safedata, options: []))
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }.resume()
            
            
            
        }
    }
    
}

