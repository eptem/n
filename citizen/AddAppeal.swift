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
    
    var currentType = "type 1"
    
    let typeOfAppeal = ["type 1", "type 2", "type 3", "type 4", "type 5", "type 6"]
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var addButton: UIButton!
    

    @IBAction func addButtonTapped(_ sender: Any) {
        textView.endEditing(true)
        let appealDB = Database.database().reference().child("appeals")
        if let text = textView.text {
            let appeal = Appeal()
            appeal.message = text
            appeal.sender = (Auth.auth().currentUser?.email)!
            appeal.type = currentType
            try! realm.write {
                realm.add(appeal)
            }
            print(realm.objects(Appeal.self))
            let appealDictionary = ["Sender" : Auth.auth().currentUser?.email,"text" : text, "type" : currentType]
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}
extension AddAppealViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeOfAppeal.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeOfAppeal[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentType = typeOfAppeal[row]
    }
}
