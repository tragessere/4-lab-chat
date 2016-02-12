//
//  ChatViewController.swift
//  Chat
//
//  Created by Evan on 2/11/16.
//  Copyright © 2016 EvanTragesser. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!

    var messages: [PFObject]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.delegate = self
      tableView.dataSource = self
      
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 44

        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTimer() {
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (messages: [PFObject]?, error: NSError?) -> Void in
          
          if error != nil {
            print("error: \(error!.description)")
            return
          }
          
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            } else {
                
            }
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

  @IBAction func sendAction(sender: AnyObject) {
    if messageTextField.text == nil || messageTextField.text!.isEmpty {
      return
    }
    
    let chatMessage = PFObject(className: "Message")
    chatMessage["user"] = PFUser.currentUser()
    chatMessage["text"] = messageTextField.text
    
    
    chatMessage.saveInBackgroundWithBlock {
      (success: Bool, error: NSError?) -> Void in
      if success {
        self.messageTextField.text = ""
      } else {
        print("Error: \(error?.description)")
      }
    }
  }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! ChatCell
        cell.chatTextLabel.text = messages![indexPath.row]["text"] as? String
        
        if let user = messages![indexPath.row]["user"] as? PFUser {
          cell.userLabel.text = user.username
        } else {
          cell.userLabel.text = ""
        }
      
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        }
        return 0
    }
}
