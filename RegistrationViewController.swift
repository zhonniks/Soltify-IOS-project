//
//  RegistrationViewController.swift
//  Soltify
//
//  Created by Zhannel Omarova on 27.12.2024.
//

import UIKit
import FirebaseAuth
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var EnterFirstNameField: UITextField!
    @IBOutlet weak var EnterLastNameField: UITextField!
    @IBOutlet weak var EnterPasswordField: UITextField!
    @IBOutlet weak var EnterVerification: UITextField!
    @IBOutlet weak var EnterEmailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpClicked(_ sender: UIButton) {
        guard let email = EnterEmailField.text, !email.isEmpty else {
            print("Email is required")
            return
        }
        guard let password = EnterPasswordField.text, !password.isEmpty else {
            print("Password is required")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                // Handle the error properly
                print("Error creating user: \(error.localizedDescription)")
            } else {
                // Navigate to the next screen
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }
    
   

}
