//
//  ViewController.swift
//  Trashure
//
//  Created by Gus Adi on 17/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    
    private let button = UIButton(type: .custom)
    
    //MARK: - Main View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //MARK: - Customize UI
    private func setupView() {
        //textfield customize
        emailField.layer.masksToBounds = true
        emailField.layer.cornerRadius = 4
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor(named: "abu")?.cgColor
        
        passField.layer.masksToBounds = true
        passField.layer.cornerRadius = 4
        passField.layer.borderWidth = 1
        passField.layer.borderColor = UIColor(named: "abu")?.cgColor
        
        
        //rightbutton password
        button.setImage(UIImage(named: "look"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 15)
        button.frame = CGRect(x: CGFloat(passField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.openPass), for: .touchUpInside)
        passField.rightView = button
        passField.rightViewMode = .always
        
        //button
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 5
        loginButton.layer.shadowColor = UIColor(named: "green")?.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        loginButton.layer.shadowOpacity = 0.25
        loginButton.layer.shadowRadius = 12
        loginButton.layer.masksToBounds = false
        
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
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
    }

    //MARK: - Actionable
    @IBAction func openPass(_ sender: Any) {
        if passField.isSecureTextEntry {
            passField.isSecureTextEntry = false
            button.setImage(UIImage(named: "lookclick"), for: .normal)
        } else {
            passField.isSecureTextEntry = true
            button.setImage(UIImage(named: "look"), for: .normal)
        }
    }
    
    @IBAction func masukPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toHome", sender: self)
    }
    
    @IBAction func daftarPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toRegister", sender: self)
    }
    
    
    @IBAction func forgetPressed(_ sender: UIButton) {
    }
    
}

