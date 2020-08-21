//
//  ReminderViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 29/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import Firebase

var listOfReminder = [String]()

class ReminderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let haptic = haptickFeedback()
    let db = Firestore.firestore()
    
    var listOfReminder = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        loadData()
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    @IBAction func addBtn(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: nil)
        haptic.haptiFeedback1()
    }
    
}


extension ReminderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfReminder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReminderTableViewCell
        cell.reminderLbl?.text = listOfReminder[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            listOfReminder.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}//db.collection(ePocket.FStore.collectionname).document(userID).collection("Reminders").document().addSnapshotListener

extension ReminderViewController {
    
    func loadData() {
        
        let userID = Auth.auth().currentUser!.uid
      //  let collectionID = Auth.auth().currentUser!.uid
       // let collection = db.collection(ePocket.FStore.collectionname).document(userID).collection("Reminders").document()
        db.collection(ePocket.FStore.collectionname).document(userID).collection("Reminders").document().addSnapshotListener { (querySnapshot, error) in
            
            if error != nil {
                
               print(error!)
                
            }
                
            else {
                if let document = querySnapshot, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    
                    self.listOfReminder.append(document["Reminder"] as! String)
                    
                } else {
                    print("Document does not exist")
                }
                
            }
        }
        
    }
    
  
}
