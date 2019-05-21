//
//  AddAppeal.swift
//  citizen
//
//  Created by Артем Жорницкий on 06/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import RealmSwift
class AddAppealViewController : UIViewController {
    
    let realm = try! Realm()
    
    let typeOfAppeal = ["type 1", "type 2", "type 3", "type 4", "type 5", "type 6"]
    var appealType : String? = nil
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    

    @IBAction func addButtonTapped(_ sender: Any) {
        textView.endEditing(true)
        let appealDB = Database.database().reference().child("appeals")
        if let text = textView.text {
            let appeal = Appeal()
            appeal.message = text
            appeal.sender = (Auth.auth().currentUser?.email)!
            appeal.type = appealType ?? "random"
            try! realm.write {
                realm.add(appeal)
            }
            print(realm.objects(Appeal.self))
            let appealDictionary = ["Sender" : Auth.auth().currentUser?.email,"text" : text, "type" : appealType]
            appealDB.childByAutoId().setValue(appealDictionary) {
                (error, reference) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    print("uploaded")
                    self.addButton.titleLabel?.text = "gotovo"
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

