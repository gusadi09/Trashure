//
//  ScanViewController.swift
//  Trashure
//
//  Created by Gus Adi on 25/11/20.
//

import UIKit

class ScanViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var inputTextButton: UIButton!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var barcodeButton: UIButton!
    @IBOutlet weak var viewConnect: UIView!
    @IBOutlet weak var putuskanButton: UIButton!
    @IBOutlet weak var keteranganLabel: UILabel!
    
    var isConnect = false
    
    let barcodeVal = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScan()
        setupConnect()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
      
        let label = UILabel()
        label.textColor = UIColor(named: "DarkBlue")
        label.text = "Scan"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        
        keteranganLabel.text = "Trashbag dengan ID \(barcodeVal) masih tersambung"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isConnect == true {
            DispatchQueue.main.async {
                self.viewConnect.isHidden = false
                self.allView.isHidden = true
            }
        } else {
            DispatchQueue.main.async {
                self.viewConnect.isHidden = true
                self.allView.isHidden = false
            }
        }
    }
    
    func setupScan() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.idTextField.frame.height))
        idTextField.leftView = paddingView
        idTextField.leftViewMode = UITextField.ViewMode.always
        
        idTextField.clipsToBounds = true
        idTextField.layer.cornerRadius = 5
        idTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        inputTextButton.clipsToBounds = true
        inputTextButton.layer.cornerRadius = 5
        inputTextButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        allView.clipsToBounds = true
        allView.layer.cornerRadius = 5
        allView.layer.shadowColor = UIColor.black.cgColor
        allView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        allView.layer.shadowOpacity = 0.1
        allView.layer.shadowRadius = 12
        allView.layer.masksToBounds = false
        
        barcodeButton.adjustsImageWhenHighlighted = false
    }
    
    func setupConnect() {
        viewConnect.clipsToBounds = true
        viewConnect.layer.cornerRadius = 5
        viewConnect.layer.shadowColor = UIColor.black.cgColor
        viewConnect.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewConnect.layer.shadowOpacity = 0.1
        viewConnect.layer.shadowRadius = 12
        viewConnect.layer.masksToBounds = false
        
        putuskanButton.clipsToBounds = true
        putuskanButton.layer.cornerRadius = 5
        putuskanButton.layer.masksToBounds = false
    }
   
    @IBAction func barcodePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCamera", sender: self)
    }
    
    @IBAction func putuskanPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.viewConnect.isHidden = true
            self.allView.isHidden = false
            self.isConnect = false
        }
    }
}
