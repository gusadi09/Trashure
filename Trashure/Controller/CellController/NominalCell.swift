//
//  NominalCell.swift
//  Trashure
//
//  Created by Gus Adi on 09/12/20.
//

import UIKit

class NominalCell: UITableViewCell {
    @IBOutlet weak var nominalLabel: UILabel!
    @IBOutlet weak var hargaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
