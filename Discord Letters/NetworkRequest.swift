//
//  NetworkRequest.swift
//  Discord Letters
//
//  Created by Guðmundur Halldórsson on 26/01/2018.
//  Copyright © 2018 Guðmundur Halldórsson. All rights reserved.
//

import AppKit

class NetworkRequest{
    
    var url: URL
    var params: String
    var onLoad: ((Data) -> Void)?
    var method = "GET"
    var dataTask: URLSessionDataTask
    
    init()
    {
        self.url = URL(string: "http://localhost")!
        self.params = ""
        self.onLoad = nil
        self.dataTask = URLSessionDataTask()
    }
    
    init(url: String, params: String, onLoad: ((Data) -> Void)?, method: String = "GET")
    {
        /*Domain will be added to the beginning of the url*/
        self.url = URL(string: "https://files.gudmunduro.com/discord_letters/" + url)!
        self.params = params
        self.onLoad = onLoad
        self.dataTask = URLSessionDataTask()
        self.method = method
    }
    
    init(customUrl: String, params: String, onLoad: ((Data) -> Void)?, method: String = "GET")
    {
        self.url = URL(string: customUrl)!
        self.params = params
        self.onLoad = onLoad
        self.dataTask = URLSessionDataTask()
        self.method = method
    }
    
    func send()
    {
        let rq = NSMutableURLRequest(url: self.url as URL)
        rq.httpMethod = self.method
        rq.httpBody = params.data(using: String.Encoding.utf8)
        self.dataTask = URLSession.shared.dataTask(with: rq as URLRequest, completionHandler: { data, response, error in
            guard error == nil && data != nil else {
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Status code: \(httpStatus.statusCode)")
                print("Response: \(String(describing: response))")
                return
            }
            
            self.onLoad!(data!)
        })
        self.dataTask.resume()
    }
}
