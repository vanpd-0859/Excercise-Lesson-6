//
//  ReposCell.swift
//  Lesson 6
//
//  Created by Phan Dinh Van on 3/14/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import UIKit

class ReposCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblWatchersCount: UILabel!
    @IBOutlet weak var lblStarsCount: UILabel!
    @IBOutlet weak var lblForksCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
