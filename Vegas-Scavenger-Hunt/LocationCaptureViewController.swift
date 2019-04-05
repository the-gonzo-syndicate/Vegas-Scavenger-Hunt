//
//  LocationCaptureViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import CoreML
import Vision

class LocationCaptureViewController: UIViewController {
    //Outlets to controls
    @IBOutlet weak var scene: UIImageView!
    @IBOutlet weak var sceneLabel: UILabel!
    
    // MARK: - Properties
    let vowels: [Character] = ["a", "e", "i", "o", "u"]
    
    //View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "train_night") else {
            fatalError("no starting image")
        }
        //Set the placeholder image
        scene.image = image
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        
        detectScene(image: ciImage)  }
}

//Function to let the user pick an image.
extension LocationCaptureViewController{
    @IBAction func pickImage(_ sender: Any) {
        
        //Instantiate the picker
        let picker = UIImagePickerController()
        picker.delegate = self
        
        //Check if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Camera is available")
            picker.sourceType = .camera
        }
        //Use photo library otherwise
        else{
            print("Camera isn't available")
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
}

//Function that starts a request for CoreML model
extension LocationCaptureViewController {
    
    func detectScene(image: CIImage) {
        
        //Create local variables
        
        //let faceRequest = VNDetectFaceRectanglesRequest(completionHandler: faceDetected)
        //https://developer.apple.com/documentation/vision/detecting_objects_in_still_images
        //
        //Update Progress
        sceneLabel.text = "detecting scene..."
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("can't load Places ML model")
        }

        //Create requests
        
        let placesRequest = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            // Update UI on main queue
            let article = (self?.vowels.contains(topResult.identifier.first!))! ? "an" : "a"
            DispatchQueue.main.async { [weak self] in
                self?.sceneLabel.text = "\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)"
            }
        }

        // Handle the requests made
        let handler = VNImageRequestHandler(ciImage: image, orientation: .up, options: [:])
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try
                handler.perform([placesRequest]);
            } catch {
                print(error)
            }
        }
    //End detectScene()
    }
}
// MARK: - UIImagePickerControllerDelegate - What happens when user is done picking an image
extension LocationCaptureViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Dismisss the view
        dismiss(animated: true, completion: nil)
        
        //Set the scene imageview
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("couldn't load image from Photos")
        }

        //Get CIImage data to detect scene
        guard let ciImage = CIImage(image: image) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        //Invoke detectScene()
        detectScene(image: ciImage)
        
    }
}

// MARK: - UINavigationControllerDelegate
extension LocationCaptureViewController: UINavigationControllerDelegate {
    
}
//Function to rotate the orientation of the image for detection purposes
func rotateImage(image: UIImage) -> UIImage {
    return UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .up)
}
