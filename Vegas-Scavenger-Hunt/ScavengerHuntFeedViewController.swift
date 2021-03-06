//
//  ScavengerHuntFeedViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage


class ScavengerHuntFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var hunts = [PFObject]()
    
    var selectedHunt = PFObject(className: "Hunts")
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Hunt")
        query.includeKeys(["huntName", "huntDifficulty", "huntStopCount", "huntImg", "huntBio"])
        //query.order(byDecending: "createdAt")
        query.limit = 20
        query.findObjectsInBackground { (hunts, error) in
            
            if hunts != nil {
                self.hunts = hunts!
                print(self.hunts)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hunts.count
        
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return hunts.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let hunt = hunts[indexPath.row]
        
        //if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScavengerHuntCellTableViewCell") as! ScavengerHuntCellTableViewCell
        
        let hunt = hunts[indexPath.row]
            
        let name = hunt["huntName"] as! String
        cell.huntNameLabel.text = name
            
        let stops = hunt["huntStopCount"] as! Int
        cell.stopCountLabel.text = "Number of Stops: \(stops)"
        
            
        let difficulty = hunt["huntDifficulty"] as! String
        cell.difficultyLabel.text = "Difficulty: \(difficulty)"
            
        let imageFile = hunt["huntImg"] as! PFFileObject
        let urlString = imageFile.url!
            
        let url = URL(string: urlString)!
            
        cell.photoView.af_setImage(withURL: url)
        cell.photoView.layer.cornerRadius = 20
        cell.photoView.clipsToBounds = true
        cell.photoView.layer.borderColor = UIColor.black.cgColor
        cell.photoView.layer.borderWidth = 6
        
        return cell
        //}

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        selectedHunt = hunts[row]
        
        self.performSegue(withIdentifier: "huntFeedToHuntDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is HuntDetailViewController) {
            let vc = segue.destination as! HuntDetailViewController
            vc.catchHunt = selectedHunt
        }
    }

    /*
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
