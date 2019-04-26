//
//  leaderboardCell.swift
//  Vegas-Scavenger-Hunt
//
//  Created by SKY HARTMAN on 4/25/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class leaderboardCell: UITableViewCell {
    
    
    @IBOutlet weak var leaderBoardImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
