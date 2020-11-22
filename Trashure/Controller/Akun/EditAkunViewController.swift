//
//  EditAkunViewController.swift
//  Trashure
//
//  Created by Gus Adi on 22/11/20.
//

import UIKit

class EditAkunViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var simpanButton: UIButton!
    
    let thickness: CGFloat = 4.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        let lineViewName = UIView(frame: CGRect(x: 0, y: nameField.frame.size.height + thickness, width: nameField.frame.size.width, height: 1))
        lineViewName.backgroundColor = .opaqueSeparator
        
        nameField.addSubview(lineViewName)
        
        let lineViewPhone = UIView(frame: CGRect(x: 0, y: phoneField.frame.size.height + thickness, width: phoneField.frame.size.width, height: 1))
        lineViewPhone.backgroundColor = .opaqueSeparator
        
        phoneField.addSubview(lineViewPhone)
        
        let lineViewEmail = UIView(frame: CGRect(x: 0, y: emailField.frame.size.height + thickness, width: emailField.frame.size.width, height: 1))
        lineViewEmail.backgroundColor = .opaqueSeparator
        
        emailField.addSubview(lineViewEmail)
        
        let lineViewBirth = UIView(frame: CGRect(x: 0, y: birthField.frame.size.height + thickness, width: birthField.frame.size.width, height: 1))
        lineViewBirth.backgroundColor = .opaqueSeparator
        
        birthField.addSubview(lineViewBirth)
        
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
    }
    @IBAction func simpanPressed(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
