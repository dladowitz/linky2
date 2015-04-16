//
//  TopicsCollection.swift
//  linky2
//
//  Created by David Ladowitz on 4/15/15.
//  Copyright (c) 2015 David Ladowitz. All rights reserved.
//

import Foundation

struct Topic {
    var resources: [String]
    
    init(messagesArray: NSArray){
        resources = []
        
        for message in messagesArray {
//            println(message)
            resources.append(message["message_text"] as! String)
        }
    }
    
}