//
//  RegistrationViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameField.delegate = self
        passwordField.delegate = self
        emailField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createAccount(_ sender: Any) {
        
        let user = PFUser()
        user.username = userNameField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        user["pointsCount"] = 0
        user["stopCount"] = 0
        user["huntCount"] = 0
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "creationToScavengerHuntSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func hideKeyboard() {
        
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
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
