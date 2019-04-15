//
//  StopListCell.swift
//  Vegas-Scavenger-Hunt
//
//  Created by Andrew on 4/14/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class StopListCell: UITableViewCell {
    
    
    @IBOutlet weak var stopNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
