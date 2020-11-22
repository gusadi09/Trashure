//
//  RegisterViewController.swift
//  Trashure
//
//  Created by Gus Adi on 20/10/20.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var namaField: DesignableTextField!
    @IBOutlet weak var emailField: DesignableTextField!
    @IBOutlet weak var noHpField: DesignableTextField!
    @IBOutlet weak var passTextField: DesignableTextField!
    @IBOutlet weak var daftarButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    
    private let button = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    //MARK: - Customize UI
    private func setupUI() {
        //custom text field
        namaField.layer.masksToBounds = true
        namaField.layer.cornerRadius = 4
        namaField.layer.borderWidth = 1
        namaField.layer.borderColor = UIColor(named: "abu")?.cgColor
        
        emailField.layer.masksToBounds = true
        emailField.layer.cornerRadius = 4
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor(named: "abu")?.cgColor
        
        noHpField.layer.masksToBounds = true
        noHpField.layer.cornerRadius = 4
        noHpField.layer.borderWidth = 1
        noHpField.layer.borderColor = UIColor(named: "abu")?.cgColor
        
        passTextField.layer.masksToBounds = true
        passTextField.layer.cornerRadius = 4
        passTextField.layer.borderWidth = 1
        passTextField.layer.borderColor = UIColor(named: "abu")?.cgColor
        
        
        //rightbutton password
        button.setImage(UIImage(named: "look"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 15)
        button.frame = CGRect(x: CGFloat(passTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.changeLook), for: .touchUpInside)
        passTextField.rightView = button
        passTextField.rightViewMode = .always
        
        //custom button
        daftarButton.clipsToBounds = true
        daftarButton.layer.cornerRadius = 5
        daftarButton.layer.shadowColor = UIColor(named: "green")?.cgColor
        daftarButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        daftarButton.layer.shadowOpacity = 0.25
        daftarButton.layer.shadowRadius = 12
        daftarButton.layer.masksToBounds = false
        
        googleButton.clipsToBounds = true
        googleButton.layer.cornerRadius = 5
        googleButton.layer.shadowColor = UIColor(named: "green")?.cgColor
        googleButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        googleButton.layer.shadowOpacity = 0.25
        googleButton.layer.shadowRadius = 12
        googleButton.layer.masksToBounds = false
        
        fbButton.clipsToBounds = true
        fbButton.layer.cornerRadius = 5
        fbButton.layer.shadowColor = UIColor(named: "green")?.cgColor
        fbButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        fbButton.layer.shadowOpacity = 0.25
        fbButton.layer.shadowRadius = 12
        fbButton.layer.masksToBounds = false
        
        //custom navbar
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .medium)]
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")

        navigationController?.navigationBar.tintColor = UIColor(named: "DarkBlue")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK: - Actionable Button
    @IBAction func changeLook(_ sender: Any) {
        if passTextField.isSecureTextEntry {
            passTextField.isSecureTextEntry = false
            button.setImage(UIImage(named: "lookclick"), for: .normal)
        } else {
            passTextField.isSecureTextEntry = true
            button.setImage(UIImage(named: "look"), for: .normal)
        }
    }
    
    @IBAction func masukPressed(_ sender: UIButton) {
    }
}
