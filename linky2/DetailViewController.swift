//
//  DetailViewController.swift
//  linky2
//
//  Created by David Ladowitz on 4/14/15.
//  Copyright (c) 2015 David Ladowitz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var topic = "Unknown"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Hey I'm in the detail view controller")
        println("the topic is \(topic)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
