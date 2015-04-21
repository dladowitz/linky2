//
//  ShareViewController.swift
//  linky
//
//  Created by David Ladowitz on 4/21/15.
//  Copyright (c) 2015 David Ladowitz. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        println(contentText)
        return true
    }
    
    override func didSelectPost() {
        
        var item = self.extensionContext!.inputItems[0] as! NSExtensionItem
        var itemProvider = item.attachments![0] as! NSItemProvider
        
        itemProvider.loadItemForTypeIdentifier("public.url", options: nil) { (link, error) -> Void in
            println(link)
            
            self.postJSON(topic: self.contentText.lowercaseString, topicLink: (link! as! NSURL).absoluteString!)
            self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
        }
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
    }
    
    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return NSArray() as [AnyObject]
    }
    
    func postJSON(#topic: String?, topicLink: String?){
        println(topic)
        println(topicLink)
        
        if let topic = topic {
            
            var request = NSMutableURLRequest(URL: NSURL(string: "http://tradecraftmessagehub.com/linky/\(topic)")!)
            var session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"
            
            var params = ["user_name":"david", "message_text": topicLink!] as Dictionary<String, String>
            
            var err: NSError?
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                println("Response: \(response)")
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)")
                var err: NSError?
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    println(err!.localizedDescription)
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: '\(jsonStr)'")
                }
                else {
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    if let parseJSON = json {
                        // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                        var success = parseJSON["success"] as? Int
                        println("Succes: \(success)")
                    }
                    else {
                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println("Error could not parse JSON: \(jsonStr)")
                    }
                }
            })
            
            task.resume()
            
        }
        
    }
    
}