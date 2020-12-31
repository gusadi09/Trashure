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
    @IBOutlet weak var nominalButton: UIButton!
    
    let thickness: CGFloat = 1.0
    
    var nominal = 0
    var harga = 0
    
    var imagesView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    var names = ""
    var hp = ""
    
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
            nohpField.rightViewMode = .always
            imagesView.contentMode = .scaleAspectFit
            let prefix = nohpField.text!.prefix(4)
            switch prefix {
            case "0811", "0852", "0853", "0812", "0813", "0821", "0822", "0851":
         
                let img = UIImage(named: "logoTelkomsel")
                
                names = "Telkomsel"
            
                imagesView.image = img
                nohpField.rightView = imagesView
            case "0817", "0818", "0819", "0859", "0877", "0878", "0879":
       
                let img = UIImage(named: "logoXL")
       
                names = "XL Axiata"
                
                imagesView.image = img
                nohpField.rightView = imagesView
            case "0814", "0815", "0816", "0855", "0856", "0857", "0858":
             
                let img = UIImage(named: "logoIndosat")
     
                names = "Indosat Ooredoo"
            
                imagesView.image = img
                nohpField.rightView = imagesView
            case "0896", "0897", "0898", "0899":
    
                let img = UIImage(named: "logoTri")
                
                names = "Tri Indonesia"
     
              
                imagesView.image = img
                nohpField.rightView = imagesView
            case "0831", "0838":
                print("axis")
                let img = UIImage(named: "logoAxis")
                
                names = "Axis"
            
                
                imagesView.image = img
                nohpField.rightView = imagesView
            case "0881", "0882", "0883", "0884":
       
                let img = UIImage(named: "logoSmart")
                
                names = "Smartfren"
          
                
                imagesView.image = img
                nohpField.rightView = imagesView
            default:
            
                nohpField.rightViewMode = .never
                nohpField.rightView = nil
                
            }
        } else {
            print("not Pulsa")
            names = "not pulsa"
        }
    }
    
    @IBAction func openNominalPressed(_ sender: Any) {
        
    }
    
    @IBAction func tukarPressed(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
