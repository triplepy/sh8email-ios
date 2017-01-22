//
//  sh8mailTableViewCell.swift
//  sh8email
//
//  Created by Hun Jae Lee on 1/21/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import UIKit

class sh8mailTableViewCell: UITableViewCell {
	@IBOutlet var senderLabel: UILabel!
	@IBOutlet var recipDateLabel: UILabel!
	@IBOutlet var subjectLabel: UILabel!
	@IBOutlet var contentsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
