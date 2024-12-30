//
//  LogInViewController.swift
//  Soltify
//
//  Created by Zhannel Omarova on 24.12.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var EnterEmailField: UITextField!
    @IBOutlet weak var EnterPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LogInClicked(_ sender: UIButton) {
        guard let email = EnterEmailField.text, !email.isEmpty else {
            print("Email is required.")
            return
        }
        guard let password = EnterPassword.text, !password.isEmpty else {
            print("Password is required.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                print("Login failed: \(error.localizedDescription)")
            } else {
                self?.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }
}
