//
//  PenukaranTableViewCell.swift
//  Trashure
//
//  Created by Gus Adi on 05/12/20.
//

import UIKit

class PenukaranTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var dropdownImage: UIImageView!
    @IBOutlet weak var expandView: UIView!
    @IBOutlet weak var separatorOne: UIView!
    @IBOutlet weak var nohpLabel: UILabel!
    @IBOutlet weak var nohpField: UITextField!
    @IBOutlet weak var nominalLabel: UILabel!
    @IBOutlet weak var nominalText: UILabel!
    @IBOutlet weak var openNominalButton: UIButton!
    @IBOutlet weak var hargalabel: UILabel!
    @IBOutlet weak var hargaText: UILabel!
    @IBOutlet weak var tukarButton: UIButton!
    @IBOutlet weak var separatorTwo: UIView!
    
    let thickness: CGFloat = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expandView.clipsToBounds = true
        expandView.layer.cornerRadius = 5
        expandView.layer.shadowColor = UIColor.black.cgColor
        expandView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        expandView.layer.shadowOpacity = 0.1
        expandView.layer.shadowRadius = 12
        expandView.layer.masksToBounds = false
        
        tukarButton.clipsToBounds = true
        tukarButton.layer.cornerRadius = 5
        tukarButton.layer.shadowColor = UIColor.black.cgColor
        tukarButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        tukarButton.layer.shadowOpacity = 0.1
        tukarButton.layer.shadowRadius = 12
        tukarButton.layer.masksToBounds = false
        
        let lineViewHp = UIView(frame: CGRect(x: 0, y: nohpField.frame.size.height + thickness, width: nohpField.frame.size.width, height: 1))
        lineViewHp.backgroundColor = .systemGray2
        
        nohpField.addSubview(lineViewHp)
        
        nohpField.keyboardType = .numberPad
    }
    
    @IBAction func startEditing(_ sender: UITextField) {
        if cellLabel.text == "Pulsa" {
            let prefix = nohpField.text!.prefix(4)
                switch prefix {
                case "0811":
                    print("telkomsel")
                default:
                    print("another provider")
                
            }
        } else {
            print("not Pulsa")
        }
    }

    @IBAction func opeNominalPressed(_ sender: Any) {
    }
    
    @IBAction func tukarPressed(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
