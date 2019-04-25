//
//  LoginViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameField.delegate = self
        passwordField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        
        let username = userNameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username as String!, password: password as String!) {
            (loggedInUser, signupError) in
            if (signupError == nil) {
                
                self.successfulSegue()
                
            } else {
                
                print("Error: \(String(describing: signupError?.localizedDescription))")
                
                var alertController = UIAlertController(title: "Error", message: "Error: Incorrect Username/Password", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func successfulSegue() {
        
        self.performSegue(withIdentifier: "loginToScavengerHuntSegue", sender: self)
    }
    
    @IBAction func onCreate(_ sender: Any) {
        
        self.performSegue(withIdentifier: "loginToRegistrationSegue", sender: self)
    }
    
    func hideKeyboard() {
        
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    
    // UItextfield delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        hideKeyboard()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
