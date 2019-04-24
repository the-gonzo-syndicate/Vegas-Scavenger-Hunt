//
//  ProfileViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var huntsLabel: UILabel!
    
    @IBOutlet weak var stopsLabel: UILabel!
    
    var currentUser = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)

        // Do any additional setup after loading the view.
        let pointsInt : Int = currentUser?["pointsCount"] as? Int ?? 0
        let pointsString = String(pointsInt)
        
        let huntsInt : Int = currentUser?["huntCount"] as? Int ?? 0
        let huntsString = String(huntsInt)
        
        let stopsInt : Int = currentUser?["stopCount"] as? Int ?? 0
        let stopsString = String(stopsInt)
        
        usernameLabel.text = currentUser?["username"] as? String
        pointsLabel.text = pointsString
        huntsLabel.text = huntsString
        stopsLabel.text = stopsString
        
        if (currentUser?["profileImg"] != nil) {
            let imageFile = currentUser?["profileImg"] as! PFFileObject
            let urlString = imageFile.url!
            
            let url = URL(string: urlString)!
            
            profileImage.af_setImage(withURL: url)
            
        }
        
 
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 6
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    

    
    @IBAction func onCameraButton(_ sender: Any) {
        
        print("click!")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alert = UIAlertController(title: nil, message: "Choose your source", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profileImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
        let imageData = profileImage.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        currentUser?["profileImg"] = file
        
        currentUser?.saveInBackground { (success, error) in
            if success {
                print("Profile image saved!")
            } else {
                print("Error saving profile pic")
            }
        }
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
