//
//  AddViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 02/08/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController {
    
    @IBOutlet weak var reminderTextField: UITextField!
    
    let db = Firestore.firestore()
    let haptic = haptickFeedback()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if reminderTextField.text != "" {
            
            let UID = Auth.auth().currentUser!.uid
           // let collection1 = self.db.collection(ePocket.FStore.collectionname).document(UID).collection("Reminders").collectionID
            let collection = self.db.collection(ePocket.FStore.collectionname).document(UID).collection("Reminders")
            let reminder = reminderTextField.text!
            
            collection.addDocument(data: [
                ePocket.FStore.reminder: reminder as String
            ])
            
            reminderTextField.text = ""
            self.dismiss(animated: true, completion: nil)
            haptic.haptiFeedback1()
            
        }else {
            let alert = UIAlertController(title: "Error", message: "Field Is Empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    
}
