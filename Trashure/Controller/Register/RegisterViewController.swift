//
//  RegisterViewController.swift
//  Trashure
//
//  Created by Gus Adi on 20/10/20.
//

import UIKit
import Firebase
import FirebaseFirestore
import FBSDKLoginKit
import GoogleSignIn
import FirebaseAuth

class RegisterViewController: UIViewController, GIDSignInDelegate {
    @IBOutlet weak var namaField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var noHpField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var daftarButton: UIButton!
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var fbButton: UIButton!
    
    private let button = UIButton(type: .custom)
    private let db = Firestore.firestore()
    var saldo = 0
    let defaults = UserDefaults.standard
    
    var birth = ""
    var mail = ""
    var nohp = ""
    var userpic = ""
    var nama = ""
    var uid = ""
    var level = ""
    var uang = ""
    var usid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser?, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            let userId = user?.userID
            let fullName = user?.profile.name
            let email = user?.profile.email
            let image = user?.profile.imageURL(withDimension: 100)
            
            let ref = self.db.collection("users").document(String(describing: userId!))
            ref.setData( [
                "uid": userId!,
                "nama": fullName ?? "",
                "nohp": "",
                "email": email ?? "",
                "birth": "",
                "userpic": String(describing: image!),
                "level": "Trashure Junior",
                "Saldo": "Rp.\(saldo)"
            ]) { err in
                if let e = err {
                    print("Error adding document: \(e)")
                } else {
                    print("Document added")
                }
            }
            
            db.collection("users").getDocuments { (qs, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in qs!.documents {
                        print("\(document.documentID) => \(document.data())")
                        if document.documentID == userId {
                            self.mail = document.data()["email"]! as! String
                            self.birth = document.data()["birth"]! as! String
                            self.nohp = document.data()["nohp"]! as! String
                            self.userpic = document.data()["userpic"]! as! String
                            self.nama = document.data()["nama"]! as! String
                            self.uid = document.data()["uid"]! as! String
                            self.level = document.data()["level"] as! String
                            self.uang = document.data()["Saldo"] as! String
                            
                            self.defaults.set(self.nama, forKey: "namaLengkap")
                            self.defaults.set(self.mail, forKey: "email")
                            self.defaults.set(self.userpic, forKey: "url")
                            self.defaults.set(self.nohp, forKey: "phone")
                            self.defaults.set(self.birth, forKey: "birthDate")
                            self.defaults.set(self.uid, forKey: "id")
                            self.defaults.set(self.level, forKey: "level")
                            self.defaults.set(self.uang, forKey: "saldo")
                    
                            self.defaults.synchronize()
                            
                            break
                        }
                    }
                }
            }
 
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        guard let authentication = user?.authentication else {
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (auth, error) in
            if let error = error {
                print("Firebase error")
                print(error)
                return
            }
            print("User signed in with firebase")
        }
        
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("user has disconect")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
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
        passTextField.isSecureTextEntry = true
        passTextField.textContentType = .none
        
        
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
    
    @IBAction func daftarPressed(_ sender: UIButton) {
        if let email = emailField.text, let pass = passTextField.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (authResult, err) in
                if let e = err {
                    print("error: \(e.localizedDescription)")
                    let alert = UIAlertController(title: "Perhatian!", message: "Email telah digunakan, silakan gunakan email lain", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Oke", style: .default) { (alert) in
                        self.namaField.text = ""
                        self.emailField.text = ""
                        self.noHpField.text = ""
                        self.passTextField.text = ""
                    }
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true)
                } else {
                    let userid = authResult!.user.uid
                    let name = self.namaField.text
                    let nomorhp = self.noHpField.text
                    let email = authResult!.user.email
                    
                    let ref = self.db.collection("users").document(String(describing: userid))
                    ref.setData( [
                        "uid": userid,
                        "nama": name ?? "",
                        "nohp": nomorhp ?? "",
                        "email": email ?? "",
                        "birth": "",
                        "userpic": "https://icon-library.com/images/default-user-icon/default-user-icon-4.jpg",
                        "level": "Trashure Junior",
                        "Saldo": "Rp.\(self.saldo)"
                    ]) { err in
                        if let e = err {
                            print("Error adding document: \(e)")
                        } else {
                            print("Document added")
                        }
                    }
                    
                    
                    
                    self.db.collection("users").getDocuments { (qs, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in qs!.documents {
                                print("\(document.documentID) => \(document.data())")
                                if document.documentID == userid {
                                    self.mail = document.data()["email"]! as! String
                                    self.birth = document.data()["birth"]! as! String
                                    self.nohp = document.data()["nohp"]! as! String
                                    self.userpic = document.data()["userpic"]! as! String
                                    self.nama = document.data()["nama"]! as! String
                                    self.uid = document.data()["uid"]! as! String
                                    self.level = document.data()["level"] as! String
                                    self.uang = document.data()["Saldo"] as! String
                                    
                                    self.defaults.set(self.nama, forKey: "namaLengkap")
                                    self.defaults.set(self.mail, forKey: "email")
                                    self.defaults.set(self.userpic, forKey: "url")
                                    self.defaults.set(self.nohp, forKey: "phone")
                                    self.defaults.set(self.birth, forKey: "birthDate")
                                    self.defaults.set(self.uid, forKey: "id")
                                    self.defaults.set(self.level, forKey: "level")
                                    self.defaults.set(self.uang, forKey: "saldo")
            
                                    self.defaults.synchronize()
                                    
                                    break
                                }
                            }
                        }
                    }
                    
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func masukPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func googlePressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func facebookPressed(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            
            if error != nil {
                print("failed to login: \(String(describing: error?.localizedDescription))")
            } else {
                let fbloginResult = result!
                
                if fbloginResult.isCancelled {
                    print("Operation Canceled")
                } else {
                    guard let accessToken = AccessToken.current else {
                        print("failed to get token")
                        return
                    }
                    
                    let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                    
                    Auth.auth().signIn(with: credential) { (result, error) in
                        if let error = error {
                            print("error: \(error.localizedDescription)")
                        } else {
                            let ref = self.db.collection("users").document(String(describing: result!.user.uid))
                            ref.setData( [
                                "uid": result?.user.uid ?? "",
                                "nama": result?.user.displayName ?? "",
                                "nohp": result?.user.phoneNumber ?? "",
                                "email": result?.user.email ?? "",
                                "birth": "",
                                "userpic": String(describing: result!.user.photoURL!),
                                "level": "Trashure Junior",
                                "Saldo": "Rp.\(self.saldo)"
                            ]) { err in
                                if let e = err {
                                    print("Error adding document: \(e)")
                                } else {
                                    print("Document added")
                                }
                            }
                            
                            self.db.collection("users").getDocuments { (qs, err) in
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    for document in qs!.documents {
                                        print("\(document.documentID) => \(document.data())")
                                        if document.documentID == result?.user.uid {
                                   
                                            self.mail = document.data()["email"]! as! String
                                            self.birth = document.data()["birth"]! as! String
                                            self.nohp = document.data()["nohp"]! as! String
                                            self.userpic = document.data()["userpic"]! as! String
                                            self.nama = document.data()["nama"]! as! String
                                            self.uid = document.data()["uid"]! as! String
                                            self.level = document.data()["level"] as! String
                                            self.uang = document.data()["Saldo"] as! String
                                            
                                            self.defaults.set(self.nama, forKey: "namaLengkap")
                                            self.defaults.set(self.mail, forKey: "email")
                                            self.defaults.set(self.userpic, forKey: "url")
                                            self.defaults.set(self.nohp, forKey: "phone")
                                            self.defaults.set(self.birth, forKey: "birthDate")
                                            self.defaults.set(self.uid, forKey: "id")
                                            self.defaults.set(self.level, forKey: "level")
                                            self.defaults.set(self.uang, forKey: "saldo")
                                            
                                            self.defaults.synchronize()
                                            
                                            break
                                        }
                                    }
                                }
                            }
                            
                        }
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        }
    }
}
