//
//  commentCell.swift
//  MVVMPostsApiCalling
//
//  Created by AnkurPipaliya on 11/07/23.
//

import UIKit

class commentCell: UITableViewCell {

    @IBOutlet weak var lblid: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblbody: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
