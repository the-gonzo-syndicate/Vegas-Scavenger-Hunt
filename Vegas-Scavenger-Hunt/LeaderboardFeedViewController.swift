//
//  LeaderboardFeedViewController.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class LeaderboardFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var users = [PFUser]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFUser.query()
        query?.selectKeys(["username", "pointsCount", "profileImg"])
        query?.order(byDescending: "pointsCount")
        query?.findObjectsInBackground(block: { (users, error) in
            if let error = error {
                print(error.localizedDescription)
            } else{
                self.users = users as! [PFUser]
                print(users)
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell") as! leaderboardCell
        
        let user = users[indexPath.row]
        
        let name = user["username"] as! String
        
        cell.usernameLabel.text = name
        
       // let points = user["pointsCount"] as! Int
        
       // cell.scoreLabel.text = "\(points)"
        let pointsInt : Int = user["pointsCount"] as? Int ?? 0
        let pointsString = String(pointsInt)
        
        cell.scoreLabel.text = pointsString
        
        if (user["profileImg"] != nil) {
            let imageFile = user["profileImg"] as! PFFileObject
            let urlString = imageFile.url!
        
            let url = URL(string: urlString)!
        
            cell.leaderBoardImage.af_setImage(withURL: url)
        }
        cell.leaderBoardImage.layer.cornerRadius = cell.leaderBoardImage.frame.size.width / 2
        cell.leaderBoardImage.clipsToBounds = true
        cell.leaderBoardImage.layer.borderColor = UIColor.darkGray.cgColor
        cell.leaderBoardImage.layer.borderWidth = 4
        print(users)
        return cell
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
