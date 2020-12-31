//
//  KonfirmasiBerhasilViewController.swift
//  Trashure
//
//  Created by Gus Adi on 09/12/20.
//

import UIKit

class KonfirmasiBerhasilViewController: UIViewController {
    @IBOutlet weak var succesText: UILabel!
    @IBOutlet weak var kembaliButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        succesText.text = """
                            Terima kasih telah melakukan penukaran saldo
                            Sisa saldo anda Rp. \(defaults.string(forKey: "saldo") ?? "-")
                            """
        
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
        navigationController?.popToRootViewController(animated: true)
    }
}
