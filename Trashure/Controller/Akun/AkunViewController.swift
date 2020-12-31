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
    
    let imgView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.setUI()
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            guard let name = self.defaults.string(forKey: "namaLengkap") else {return}
            guard let email = self.defaults.string(forKey: "email") else {return}
            guard let phone = self.defaults.string(forKey: "phone") else {return}
            guard let birth = self.defaults.string(forKey: "birthDate") else {return}
            guard let level = self.defaults.string(forKey: "level") else {return}
            guard let saldo = self.defaults.string(forKey: "saldo") else {return}
            let img = UserDefaults.standard.string(forKey: "url")
            
            self.profileName.text = name
            self.profilePhone.text = phone
            self.profileEmail.text = email
            self.profileLahir.text = birth
            
            let url = URL(string: img ?? "https://icon-library.com/images/default-user-icon/default-user-icon-4.jpg")
            self.imgView.kf.setImage(with: url)
            
            self.profileLevel.text = level
            self.userSaldo.text = "Rp. \(saldo)"
        }
        
    }
    
    func setUI() {

        self.imgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imgView.layer.borderWidth = 3
        imgView.layer.masksToBounds = false
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.clipsToBounds = true
        
        self.imgView.center = CGPoint(x: profileName.frame.width/2, y: profileName.frame.height/2 - 70)
        self.profileName.addSubview(imgView)
       
        DispatchQueue.main.async {
            guard let name = self.defaults.string(forKey: "namaLengkap") else {return}
            guard let email = self.defaults.string(forKey: "email") else {return}
            guard let phone = self.defaults.string(forKey: "phone") else {return}
            guard let birth = self.defaults.string(forKey: "birthDate") else {return}
            guard let level = self.defaults.string(forKey: "level") else {return}
            guard let saldo = self.defaults.string(forKey: "saldo") else {return}
            let img = UserDefaults.standard.string(forKey: "url")
            
            let url = URL(string: img ?? "https://icon-library.com/images/default-user-icon/default-user-icon-4.jpg")
            
            self.profileName.text = name
            self.profilePhone.text = phone
            self.profileEmail.text = email
            self.profileLahir.text = birth
    
            self.imgView.kf.setImage(with: url)
            
            self.profileLevel.text = level
            self.userSaldo.text = "Rp. \(saldo)"
        }
        
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
        guard let controller = segue.destination as? EditAkunViewController else {return}
        guard let name = self.profileName.text else {return}
        guard let mail = self.profileEmail.text else {return}
        guard let phone = self.profilePhone.text else {return}
        guard let lahir = self.profileLahir.text else {return}
        guard let image = self.imgView.image else {return}
        
        if segue.identifier == "toEdit" {
            DispatchQueue.main.async {
                controller.nameField?.text = name
                controller.emailField?.text = mail
                controller.phoneField?.text = phone
                controller.birthField?.text = lahir
                controller.profileImage?.image = image
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "navbarVC")
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
            //dismiss(animated: true, completion: nil)
            self.present(ViewController(), animated: true, completion: nil)
            self.defaults.set("false", forKey: "statusLogin")
            self.defaults.synchronize()
            print("sign out success")
        } catch let signOutError as NSError {
            print("error signing out: \(signOutError)")
        }
    }
    
}
