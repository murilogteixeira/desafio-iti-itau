//
//  TipoContaTableViewCell.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 29/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class TipoContaTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var saldoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
