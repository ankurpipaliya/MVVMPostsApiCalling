//
//  cell.swift
//  MVVMPostsApiCalling
//
//  Created by AnkurPipaliya on 11/07/23.
//

import UIKit

class cell: UITableViewCell {

    @IBOutlet weak var lblid: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUserid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
