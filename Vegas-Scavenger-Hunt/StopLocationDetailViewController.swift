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

class StopLocationDetailViewController: UIViewController {
    
    var catchStop = PFObject(className: "Stops")
    
    
    @IBOutlet weak var stopImageView: UIImageView!
    
    @IBOutlet weak var stopNameLabel: UILabel!
    
    @IBOutlet weak var stopBioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stopNameLabel.text = catchStop["stopName"] as? String
        stopBioLabel.text = catchStop["stopBio"] as? String
        
        if (catchStop["stopImg"] != nil) {
            
            let imageFile = catchStop["stopImg"] as! PFFileObject
            let urlString = imageFile.url!
            
            let url = URL(string: urlString)!
            
            stopImageView.af_setImage(withURL: url)
        }
    }
    

    @IBAction func onBack(_ sender: Any) {
        
        self.performSegue(withIdentifier: "stopDetailToHuntFeed", sender: self)
        
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
