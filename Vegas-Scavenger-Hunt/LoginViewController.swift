//
//  LoginViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
