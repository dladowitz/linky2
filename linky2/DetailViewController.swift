//
//  DetailViewController.swift
//  linky2
//
//  Created by David Ladowitz on 4/14/15.
//  Copyright (c) 2015 David Ladowitz. All rights reserved.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!

    var topic = "Unknown"

    override func viewDidLoad() {
        super.viewDidLoad()

        topicTitleLabel.text = topic
        downloadJSON()
        println(displayLabel.text)
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func downloadJSON(){
        let baseURL = NSURL(string: "http://tradecraftmessagehub.com/sample/schweetchannel")
//        let tradecraftURL = NSURL(string: coordinates, relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(baseURL!,
            completionHandler:{(location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
                if error == nil {
                    let dataObject = NSData(contentsOfURL: location)
                    let topicArray: NSArray = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as! NSArray
                    println(topicArray[0]["message_text"])

                    
                    var message = topicArray[0]["message_text"]! as! String
                    self.displayLabel.text = message
                }
            }
        )
        downloadTask.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
