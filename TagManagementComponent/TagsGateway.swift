//
//  TagsGateway.swift
//  TagManagementComponent
//
//  Created by Pedro Russo on 12/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit
import Foundation

class TagsGateway: NSObject {
    
    func getAllTags(onCompletion: ([Tag]) -> Void){
        
        let path = "http://mockbin.org/bin/8053044c-a645-4b17-b020-6d53fa5abedd"
        
        makeHTTPget(path, onCompletion: {json, err in
            let list = json as [NSDictionary]
        })
        

    }
    
    private func makeHTTPget(path: String, onCompletion: ([NSDictionary], NSError?) -> Void) {
        let url = NSURL(string: path)!
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            if httpResponse.statusCode == 200 {
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: nil) as! [NSDictionary]
                println(jsonData[0]["tag"])
                onCompletion(jsonData, error)
            }
            
        })
        task.resume()
    }
    
    private func tagFromDictionary(dic: NSDictionary) -> Tag {
        return Tag(id: dic["id"]!.integerValue, tag: dic["tag"]!.stringValue, color: dic["color"]!.stringValue) }
    
}
