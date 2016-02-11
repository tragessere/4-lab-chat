//
//  ViewController.swift
//  Chat
//
//  Created by Evan on 2/11/16.
//  Copyright © 2016 EvanTragesser. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

    @IBAction func onSignup(sender: AnyObject) {
        if usernameTextField.text!.isEmpty && passwordTextField.text!.isEmpty {
            return
        }
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackgroundWithBlock{
            (succeeded: Bool, error: NSError?) -> Void in
            if let error =  error {
                let errorString = error.userInfo["error"] as? NSString
                print(errorString)
            } else {
                
            }
            }
    }

    @IBAction func onLogin(sender: AnyObject) {
        if usernameTextField.text!.isEmpty && passwordTextField.text!.isEmpty {
            return
        }
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password:passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
            } else {
                // The login failed. Check error to see why.
            }
        }

        
    }
}

