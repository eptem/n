//
//  AdminViewController.swift
//  citizen
//
//  Created by Артем Жорницкий on 06/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class AdminViewController : UIViewController {
    
    var appeals = [Appeal]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        retrieveAppeals()
    }
    
    func retrieveAppeals() {
        let appealDB = Database.database().reference().child("appeals")
        appealDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let sender = snapshotValue["Sender"]
            let text = snapshotValue["text"]
            let type = snapshotValue["type"]
            //let appeal = Appeal(message: text!, sender: sender!, type: type!)
            let appeal = Appeal()
            appeal.message = text!
            appeal.sender = sender!
            appeal.type = type!
            self.appeals.append(appeal)
            //print(text,type,sender)
            self.tableView.reloadData()
        }
    }
}

extension AdminViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminCell", for : indexPath) as! AdminCell
        cell.senderLabel.text = appeals[indexPath.row].sender
        cell.typeLabel.text = appeals[indexPath.row].type
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appealVC = AppealViewController.instance() as! AppealViewController
        appealVC.text = appeals[indexPath.row].message
        navigationController?.pushViewController(appealVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
