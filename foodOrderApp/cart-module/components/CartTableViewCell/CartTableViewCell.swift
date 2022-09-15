//
//  CartTableViewCell.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 14.09.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteDetail: UILabel!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteStepper: UIStepper!
    @IBOutlet weak var noteCounterButton: UIButton!
    @IBOutlet weak var notePrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
