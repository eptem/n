//
//  RegisterViewController.swift
//  citizen
//
//  Created by Артем Жорницкий on 05/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController : UIViewController {
    
    @IBOutlet weak var loginTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registrTapped(_ sender: Any) {
        if let login = loginTextfield.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: login, password: password) { (user, error) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    print("user registrated")
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
