import UIKit



//
//// This function does everything necessary to get messages from the server and update both our models and our views when they arrive.
//func getMessages() {
//    // Post-iOS7, network requests are issued within the context of a NSURLSession. Check the docs to see all the things it can do :) We'll just ask for a standard universal instance.
//    let session = NSURLSession.sharedSession()
//    
//    // We have to construct our URL request. This is similar to what we might do in a tool like Postman.
//    let request = NSMutableURLRequest()
//    request.HTTPMethod = "GET"
//    request.URL = NSURL(string: "http://tradecraftmessagehub.com/sample/schweetchannel")
//    
//    // We're defining a data retrieval task that's meant to send out the request we've crafted. As an additional parameter, we give it a closure to execute when the data comes back (or when the request fails.)
//    let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
//        // Don't mind this NSOperationQueue line for now - it's its own discussion :) Look up concurrency if you're curious.
//        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
//            // There might have been an error...
//            if let error = error {
//                // This is a function you'll see defined below to handle errors.
//                self.alertWithError(error)
//                // But if there wasn't, use the function we're about to define a few lines below to spin up an array of Messages using the response data...
//            } else if let messages = self.messagesFromNetworkResponseData(data) {
//                // We have new messages! Update our model!
//                self.messages = messages
//                // ...And with our model updated, tell our view to update too! (It'll send all those UITableViewDataSource questions back at us again.)
//                self.tableView.reloadData()
//            }
//            // Bonus points if you can figure out why something extra should be happening here to be super-safe, and what that might look like :)
//        }
//    })
//    
//    // And since we've only defined the task and not sent it, as the final step, let's send it now. (By... resuming it for the first time.)
//    task.resume()
//}
//
//// More functions that help the first function do its job!
//
//// This function gives you an array of Messages built out of data received from the server.
//// This is a "pure function" - no "side effects", it just returns something based on the parameter.
//// It's named in fairly standard fashion for a pure function in iOS - [returnThing]From[SuppliedStuff]
//func messagesFromNetworkResponseData(responseData : NSData) -> Array<Message>? {
//    // In Objective-C, you can only return a single object from a function. The standard function we're about to use wanted to return two - if successful, the result, or if unsuccessful, an error - so they use complicated indirection to achieve something similar. (This is easier to explain in person.) But this variable facilitates that pseudo-two-returns indirection.
//    var serializationError : NSError?
//    
//    // NSJSONSerialization permits turning Swift objects into JSON and vice-versa. Check the docs on NSJSONSerialization for more details.
//    let messageAPIDictionaries = NSJSONSerialization.JSONObjectWithData(
//        responseData,
//        options: nil,
//        error: &serializationError
//        ) as Array<Dictionary<String, String>>
//    
//    // If we had an error instead of a successful result, present it to the user and return nil. (Because there could be an error, the return value had to be an optional.)
//    if let serializationError = serializationError {
//        alertWithError(serializationError)
//        return nil
//    }
//    
//    // Our "messageAPIDictionaries" is a set of standard Swift objects that corresponds with the message JSON - our next step is to take those objects and create our own custom Message objects that we've defined. This step does that using our understanding that "message_text" and "user_name" keys should exist on every JSON object that represents a message.
//    
//    // The "map" function makes a new array out of an existing array by taking the return value of this closure when run once with each object in the original array as a parameter. (So if there are three objects in the array, it's run three times, once with each of those.) That closure is the parameter to the map function, below. Note how we run the "map" function on the messageAPIDictionaries array, and similarly, name the parameter "messageAPIDictionary."
//    var messages = messageAPIDictionaries.map({ (messageAPIDictionary) -> Message in
//        // These !s mean we're asserting that these keys exist in each message dictionary.
//        // (It's better to throw an error here instead of crashing, so this is a good case for putting a TODO to fix later)
//        let messageText = messageAPIDictionary["message_text"]!
//        let userName = messageAPIDictionary["user_name"]!
//        // This return gives this new Message object back to the map function that executed the closure so it can put this new Message object into its new array behind the scenes.
//        return Message(userName: userName, text: messageText)
//    })
//    
//    // Now that we used the map function to generate an array of Messages, we're done, so just pass it back.
//    return messages
//}
//
//// This is a helper method that presents an arbitrary error to the user in a standard way.
//func alertWithError(error : NSError) {
//    // UIAlertController is the new standard way for showing the alerts that pop up in the middle of the screen.
//    let alertController = UIAlertController(
//        title: "Error",
//        message: error.description,
//        preferredStyle: UIAlertControllerStyle.Alert
//    )
//    // As a view controller, it must be presented from another view controller: here it's the current one.
//    self.presentViewController(alertController, animated: true, completion: nil)
