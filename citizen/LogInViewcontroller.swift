//
//  LogInViewcontroller.swift
//  citizen
//
//  Created by Артем Жорницкий on 05/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LogInViewController : UIViewController {
    @IBOutlet weak var loginTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    @IBAction func authButtonTapped(_ sender: Any) {
        if let login = loginTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: login, password: password) { (user, error) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    print("user logged in")
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

