//
//  DetailViewController.swift
//  linky2
//
//  Created by David Ladowitz on 4/14/15.
//  Copyright (c) 2015 David Ladowitz. All rights reserved.
//

import UIKit
import Foundation

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet
    var tableView: UITableView!
    var tableItems: [String] = []
    var topicMessages: Topic?
    
    @IBOutlet weak var topicTitleLabel: UILabel!
    var topic = "Unknown"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        topicTitleLabel.text = topic
        downloadJSON()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func downloadJSON(){
        let baseURL = NSURL(string: "http://tradecraftmessagehub.com/linky/\(topic)")
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(baseURL!,
            completionHandler:{(location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
                if error == nil {
                    let dataObject = NSData(contentsOfURL: location)
                    let topicArray: NSArray = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as! NSArray
                    
                    self.topicMessages = Topic(messagesArray: topicArray)
                    println(self.topicMessages!.resources)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        for messages in self.topicMessages!.resources {
                            self.tableItems.append(messages)
                        }
                        self.tableView.reloadData()
                    })

                }
            }
        )
        downloadTask.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        
        
        cell.textLabel?.text = self.tableItems[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        if let url = NSURL(string: tableItems[indexPath.row]){
            UIApplication.sharedApplication().openURL(url)
        }
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
