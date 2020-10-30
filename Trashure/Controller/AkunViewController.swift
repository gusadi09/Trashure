//
//  AkunViewController.swift
//  Trashure
//
//  Created by Gus Adi on 30/10/20.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class AkunViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
