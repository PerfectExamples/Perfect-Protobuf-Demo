//
//  ProtoSender.swift
//  Perfect-Protobuf-Demo
//
//  Created by Ryan Collins on 2/16/17.
//
//

import Foundation

struct ProtoSender {
    func send(_ data: Data) {
        
        let urlPath = "http://localhost:8181/receive"
        
        guard let endpoint = URL(string: urlPath) else {
            print("Error creating endpoint")
            return
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error.debugDescription)
            }
            
            }.resume()
        
    }
}
