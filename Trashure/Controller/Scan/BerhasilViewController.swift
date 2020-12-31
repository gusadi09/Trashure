//
//  BerhasilViewController.swift
//  Trashure
//
//  Created by Gus Adi on 28/11/20.
//

import UIKit

class BerhasilViewController: UIViewController {
    @IBOutlet weak var succesText: UILabel!
    @IBOutlet weak var kembaliButton: UIButton!
    
    var barcodeValue = ""
    var views = ScanViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        succesText.text = "Trashbag telah tersambung Trashbag ID \(barcodeValue)"
        
        kembaliButton.clipsToBounds = true
        kembaliButton.layer.cornerRadius = 5
        kembaliButton.layer.shadowColor = UIColor(named: "green")?.cgColor
        kembaliButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        kembaliButton.layer.shadowOpacity = 0.1
        kembaliButton.layer.shadowRadius = 12
        kembaliButton.layer.masksToBounds = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func kembaliPressed(_ sender: UIButton) {
        if let rootVC = navigationController?.viewControllers.first as? ScanViewController {
            rootVC.isConnect = true
        }
        navigationController?.popToRootViewController(animated: true)
    }

}
