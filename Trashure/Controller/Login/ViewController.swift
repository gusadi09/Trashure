//
//  ViewController.swift
//  Trashure
//
//  Created by Gus Adi on 17/10/20.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase
import FBSDKLoginKit
import FirebaseFirestore


class ViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var fbButton: UIButton!

    let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    
    private let button = UIButton(type: .custom)
    var saldo = 0
    
    var birth = ""
    var mail = ""
    var nohp = ""
    var userpic = ""
    var nama = ""
    var uid = ""
    var level = ""
    var uang = ""
    
    //MARK: - Main View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toHome", sender: self)
        }
    }
    
    //MARK: -Authentikasi Google dan Facebook
    //MARK: Google
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
 
            performSegue(withIdentifier: "toHome", sender: self)
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
        if let email = emailField.text, let pass = passField.text {
            let auth = Auth.auth()
            auth.signIn(withEmail: email, password: pass) { (authResult, err) in
                if let e = err {
                    print("error: \(e)")
                } else {
            
                    self.db.collection("users").getDocuments { (qs, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in qs!.documents {
                                print("\(document.documentID) => \(document.data())")
                                if document.documentID == authResult!.user.uid {
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
                    
                    self.performSegue(withIdentifier: "RegisterToHome", sender: self)
                }
            }
        }
    }
    
    @IBAction func googlePressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    @IBAction func fbPressed(_ sender: Any) {
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
                        self.performSegue(withIdentifier: "toHome", sender: self)
                    }
                }
            }
        }
    }
    
    @IBAction func daftarPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toRegister", sender: self)
    }
    
    
    @IBAction func forgetPressed(_ sender: UIButton) {
    }
    
}

