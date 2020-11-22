//
//  AkunViewController.swift
//  Trashure
//
//  Created by Gus Adi on 30/10/20.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Kingfisher

class AkunViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileLevel: UILabel!
    @IBOutlet weak var userSaldo: UILabel!
    @IBOutlet weak var totalSampah: UILabel!
    @IBOutlet weak var profilePhone: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileLahir: UILabel!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var keluarButton: UIButton!
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()

    }
    
    func setUI() {
        let name = defaults.string(forKey: "namaLengkap")
        let email = defaults.string(forKey: "email")
        let img = defaults.string(forKey: "url")
        let phone = defaults.string(forKey: "phone")
        let birth = defaults.string(forKey: "birthDate")

        let url = URL(string: img ?? "https://icon-library.com/images/default-user-icon/default-user-icon-4.jpg")
        self.profileImage.kf.setImage(with: url)
        self.profileName.text = name
        self.profilePhone.text = phone ?? " "
        self.profileEmail.text = email
        self.profileLahir.text = birth
        
        profileImage.layer.borderWidth = 3
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        allView.clipsToBounds = true
        allView.layer.cornerRadius = 5
        allView.layer.shadowColor = UIColor.black.cgColor
        allView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        allView.layer.shadowOpacity = 0.1
        allView.layer.shadowRadius = 12
        allView.layer.masksToBounds = false
        
        indicatorView.clipsToBounds = true
        indicatorView.layer.cornerRadius = 30
        indicatorView.layer.masksToBounds = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
        
        let label = UILabel()
        label.textColor = UIColor(named: "DarkBlue")
        label.text = "Akun"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        
        keluarButton.clipsToBounds = true
        keluarButton.layer.cornerRadius = 5
        keluarButton.layer.masksToBounds = false
    }
    
    @IBAction func editPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toEdit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? EditAkunViewController
        
        if segue.identifier == "toEdit" {
            DispatchQueue.main.async {
                controller?.nameField.text = self.profileName.text
                controller?.emailField.text = self.profileEmail.text
                controller?.phoneField.text = self.profilePhone.text
                controller?.birthField.text = self.profileLahir.text
                controller?.profileImage.image = self.profileImage.image
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
            print("sign out success")
        } catch let signOutError as NSError {
            print("error signing out: \(signOutError)")
        }
    }
    
}
