//
//  MasterViewController.swift
//  linky2
//
//  Created by David Ladowitz on 4/13/15.
//  Copyright (c) 2015 David Ladowitz. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let button = sender! as! UIButton
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.topic = button.titleForState(.Normal)!
    }

}

