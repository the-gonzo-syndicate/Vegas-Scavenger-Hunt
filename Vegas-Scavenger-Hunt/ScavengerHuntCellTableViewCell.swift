//
//  ScavengerHuntCellTableViewCell.swift
//  Vegas-Scavenger-Hunt
//
//  Created by ANDREW STUDENIC on 4/11/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class ScavengerHuntCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var huntNameLabel: UILabel!
    
    @IBOutlet weak var stopCountLabel: UILabel!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
