//
//  HuntDetailViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class HuntDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stopList = [PFObject]()

    @IBOutlet weak var stopListTableView: UITableView!
    
    @IBOutlet weak var huntNameLabel: UILabel!
    
    @IBOutlet weak var huntBioLabel: UILabel!
    
    @IBOutlet weak var huntImage: UIImageView!
    
    var catchHunt = PFObject(className: "Hunt")
    
    var selectedStop = PFObject(className: "Stops")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        huntNameLabel.text = catchHunt["huntName"] as? String
        huntBioLabel.text = catchHunt["huntBio"] as? String
        
        let imageFile = catchHunt["huntImg"] as! PFFileObject
        let urlString = imageFile.url!
        
        let url = URL(string: urlString)!

        huntImage.af_setImage(withURL: url)
        
        huntImage.layer.cornerRadius = 20
        huntImage.clipsToBounds = true
        huntImage.layer.borderColor = UIColor.black.cgColor
        huntImage.layer.borderWidth = 6
        
        stopListTableView.delegate = self
        stopListTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Stops")
        query.whereKey("inHunt", equalTo: catchHunt["huntName"])
        //query.order(byDecending: "createdAt")
        query.limit = 20
        query.findObjectsInBackground { (stopList, error) in
            
            if stopList != nil {
                self.stopList = stopList!
                print(self.stopList)
                self.stopListTableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StopListCell") as! StopListCell
        
        let stop = stopList[indexPath.row]
        
        let name = "\(indexPath.row + 1). \(stop["stopName"] ?? "Error")"
        cell.stopNameLabel.text = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        selectedStop = stopList[row]
        
        self.performSegue(withIdentifier: "huntDetailToStopDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is StopLocationDetailViewController) {
            let vc = segue.destination as! StopLocationDetailViewController
            vc.catchStop = selectedStop
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        
        self.performSegue(withIdentifier: "huntDetailToHuntFeed", sender: self)
        
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
