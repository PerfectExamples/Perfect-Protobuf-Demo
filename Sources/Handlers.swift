//
//  Handlers.swift
//  Perfect-Protobuf-Demo
//
//  Created by Ryan Collins on 2/16/17.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import SwiftProtobuf
import Foundation


func sendHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        // Respond with a simple message.
        
        if !request.postParams.isEmpty {
            
            var title: String? = nil
            var body: String? = nil
            
            for param in request.postParams {
                if param.0 == "title" {
                    title = param.1
                } else if param.0 == "message" {
                    body = param.1
                }
            }
            
            if let messageTitle = title, let messageBody = body {
                var message = ChatMessage()
                message.title = messageTitle
                message.body = messageBody
                
                do {
                    let data = try message.serializeProtobuf()
                    print("Serialized Proto into Data")
                    print("Sending Proto…")
                    ProtoSender().send(data)
                } catch {
                    print("Failed to Serialize Protobuf Object into Data")
                }
            }
            
        }
        
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "<html><title>Request Received!</title><body>Request Received!</body></html>")
        // Ensure that response.completed() is called when your processing is done.
        response.completed()
    }
}

func receiveHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        // Respond with a simple message.
        
        print("Proto Received!")
        
        if let bytes = request.postBodyBytes {
            let data = Data(bytes: bytes)
        
            do {
                let message = try ChatMessage(protobuf: data)
                print("Proto was received and converted into a message with: \ntitle: \(message.title) \nbody of: \(message.body)")
            } catch {
                print("Failed to Decode Proto")
            }
        }
        
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "<html><title>Hello, proto!</title><body>Hello, protocol buffers!</body></html>")
        // Ensure that response.completed() is called when your processing is done.
        response.completed()
    }
}
