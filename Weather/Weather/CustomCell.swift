//
//  CustomCell.swift
//  Weather
//
//  Created by ZL on 2021/5/27.
//  Copyright © 2021 ZL. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tem: UILabel!
    @IBOutlet weak var wea: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
