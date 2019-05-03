//
//  StopLocationDetailViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class StopLocationDetailViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var locationManager = CLLocationManager()
    
    var catchStop = PFObject(className: "Stops")
    
    var currentUser = PFUser.current()
    
    var tempStop = PFObject(className: "UserStops")
    
    var array = [PFObject]()
    
    
    @IBOutlet weak var stopImageView: UIImageView!
    
    @IBOutlet weak var stopNameLabel: UILabel!
    
    @IBOutlet weak var stopBioLabel: UILabel!
    
    @IBOutlet weak var resultMessageLabel: UILabel!
    
    @IBOutlet weak var captureButton: RoundButton!
    //var longitude: Double = 0.0
    //var latitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        
        //let huntArray = currentUser?["huntArray"]
        
        if (currentUser?["stopArray"] == nil) {
            // if it is empty or not in the array
            
            
            
            print("Yeah its empty")
        } else {
            print("We got something here!")
            
            // load the found object if it is in the users array of stops
        }
        
        
        
        

        stopNameLabel.text = catchStop["stopName"] as? String
        stopBioLabel.text = catchStop["stopBio"] as? String
        
        if (catchStop["stopImg"] != nil) {
            
            let imageFile = catchStop["stopImg"] as! PFFileObject
            let urlString = imageFile.url!
            
            let url = URL(string: urlString)!
            
            stopImageView.af_setImage(withURL: url)
            
            stopImageView.layer.cornerRadius = 20
            stopImageView.clipsToBounds = true
            stopImageView.layer.borderColor = UIColor.black.cgColor
            stopImageView.layer.borderWidth = 6
            
        }
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                
                let longitude = location.coordinate.longitude
                let latitude = location.coordinate.latitude
                
                print("long = \(longitude), lat= \(latitude)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location failed, \(error)")
    }
    
    @IBAction func onBack(_ sender: Any) {
        
        self.performSegue(withIdentifier: "stopDetailToHuntFeed", sender: self)
        
    }
    
    @IBAction func onCapture(_ sender: Any) {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let userLocation = locationManager.location?.coordinate
        print("locs= \(userLocation)")
        
        let longitude = userLocation?.longitude ?? 0.0
        let latitude = userLocation?.latitude ?? 0.0
        print("lat= \(latitude)")
        print("long= \(longitude)")
        
        
        
        let currentPoint = PFGeoPoint(latitude: latitude, longitude: longitude)
        let polygon = catchStop["stopCoords"] as? PFPolygon
        
        
        if ((polygon?.contains(currentPoint))!) {
            print("yeah buddy!")
            
            //Opens camera, saves object to array, adds points, loads labels, hides button
            
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
            
            
            
            
            
            
            
        } else {
            resultMessageLabel.text = "Wrong Location, Try Again!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.resultMessageLabel.text = ""
            }
            print("Thats a no dawg.")
            print(currentPoint)
            //print(polygon)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize( width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        stopImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
        let imageData = stopImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        tempStop["stopImage"] = file
        
        captureButton.isHidden = true
        resultMessageLabel.text = "CONGRATS! You have found this stop!"
        
        tempStop["collectedStop"] = catchStop
        
        //let stopPoints = catchStop["pointsCount"] as! NSNumber
        
        let addPoints = PFUser.current()
        addPoints?.incrementKey("pointsCount", byAmount: 5)
        addPoints?.incrementKey("stopCount", byAmount:1)
        addPoints?.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                // The score key has been incremented
                print("points added")
            } else {
                // There was a problem, check error.description
                print("something went wrong with points")
            }
        }
        
        let query = PFQuery(className: "Stops")
        query.getObjectInBackground(withId: catchStop.objectId!) { (obj: PFObject?, error: Error?) in
            if let error = error {
                //The query returned an error
                print(error.localizedDescription)
            } else {
                //The object has been retrieved
                print(obj)
                self.tempStop["collectedStop"] = obj
                self.array.append(self.tempStop)
                self.currentUser!["stopArray"] = self.array
                self.currentUser?.saveInBackground(block: { (suceess, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else{
                        print("ya it save. 😀")
                    }
                })
            }
        }
        
        //let addPoints = catchStop["stopPointValue"] as! Int
        //var userPoints = currentUser?["pointsCount"] as! Int
        
        
        //userPoints = userPoints + addPoints
        
        //currentUser?["pointsCount"] = userPoints
        
        /*currentUser?.saveInBackground { (success, error) in
            if success {
                print("saved")
            } else {
                print("error saving...")
            }
        }*/
    }

}
