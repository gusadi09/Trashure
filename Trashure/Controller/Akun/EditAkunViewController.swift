//
//  EditAkunViewController.swift
//  Trashure
//
//  Created by Gus Adi on 22/11/20.
//

import UIKit
import FirebaseFirestore
import Firebase

class EditAkunViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var nameField: UITextField?
    @IBOutlet weak var phoneField: UITextField?
    @IBOutlet weak var emailField: UITextField?
    @IBOutlet weak var birthField: UITextField?
    @IBOutlet weak var simpanButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    let thickness: CGFloat = 4.0
    
    let db = Firestore.firestore()
    let defaults = UserDefaults.standard
    let storage = Storage.storage()
    
    var urlStorage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage!.layer.masksToBounds = false
        profileImage!.layer.cornerRadius = profileImage!.frame.size.height/2
        profileImage!.clipsToBounds = true
        
        let lineViewName = UIView(frame: CGRect(x: 0, y: nameField!.frame.size.height + thickness, width: nameField!.frame.size.width, height: 1))
        lineViewName.backgroundColor = .opaqueSeparator
        
        nameField!.addSubview(lineViewName)
        
        let lineViewPhone = UIView(frame: CGRect(x: 0, y: phoneField!.frame.size.height + thickness, width: phoneField!.frame.size.width, height: 1))
        lineViewPhone.backgroundColor = .opaqueSeparator
        
        phoneField!.addSubview(lineViewPhone)
        
        let lineViewEmail = UIView(frame: CGRect(x: 0, y: emailField!.frame.size.height + thickness, width: emailField!.frame.size.width, height: 1))
        lineViewEmail.backgroundColor = .opaqueSeparator
        
        emailField!.addSubview(lineViewEmail)
        
        let lineViewBirth = UIView(frame: CGRect(x: 0, y: birthField!.frame.size.height + thickness, width: birthField!.frame.size.width, height: 1))
        lineViewBirth.backgroundColor = .opaqueSeparator
        
        birthField!.addSubview(lineViewBirth)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "DarkBlue")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")

        navigationController?.navigationBar.tintColor = UIColor(named: "DarkBlue")
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 22))
        
        let title = UILabel()
        title.text = "Edit Akun"
        title.textColor = UIColor(named: "DarkBlue")
        title.font = UIFont(name: "SF UI Display Semibold", size: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(title)
        
        let leftWidth: CGFloat = 55 // left padding
        let rightWidth: CGFloat = 75 // right padding
        let width = view.frame.width - leftWidth - rightWidth
        let offset = (rightWidth - leftWidth) / 2
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: container.topAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            title.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -offset),
            title.widthAnchor.constraint(equalToConstant: width)
        ])
        
        
        self.navigationItem.titleView = container
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        
        simpanButton.clipsToBounds = true
        simpanButton.layer.cornerRadius = 5
        simpanButton.layer.masksToBounds = false

    }
    
    @IBAction func photoPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let uid = defaults.string(forKey: "id") else {return}
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            guard let data = pickedImage.jpegData(compressionQuality: 0.75) else {return}
            
            let storageRef = storage.reference()

            let photoRef = storageRef.child("images/profile\(uid).jpg")

            let uploadTask = photoRef.putData(data, metadata: nil) { (metadata, error) in
              guard let metadata = metadata else {
                return
              }
                
              let size = metadata.size
              print(size)
              photoRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  return
                }
                
                self.urlStorage = "\(downloadURL)"
                
                self.profileImage?.contentMode = .scaleAspectFill
                self.profileImage?.kf.setImage(with: downloadURL)
              }
            }
            print(uploadTask)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func simpanPressed(_ sender: UIButton) {
        guard let nama = self.nameField?.text else {return}
        guard let hp = self.phoneField?.text else {return}
        guard let email = self.emailField?.text else {return}
        guard let birth = self.birthField?.text else {return}
        
        if let uid = defaults.string(forKey: "id") {
            let sfReference = db.collection("users").document(uid)
            
            db.runTransaction { (transaction, errPointer) -> Any? in
                
                transaction.updateData(["nama" : nama, "nohp" : hp, "email" : email, "birth" : birth, "userpic" : self.urlStorage], forDocument: sfReference)
    
                return nil
            } completion: { (object, error) in
                if let error = error {
                    print("Transaction failed: \(error)")
                } else {
                    print("Transaction successfully committed!")
                    DispatchQueue.main.async {
                        self.defaults.setValue(nama, forKey: "namaLengkap")
                        self.defaults.setValue(email, forKey: "email")
                        self.defaults.setValue(birth, forKey: "birthDate")
                        self.defaults.setValue(hp, forKey: "phone")
                        self.defaults.setValue(self.urlStorage, forKey: "url")
                        
                        self.defaults.synchronize()
                    }
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
