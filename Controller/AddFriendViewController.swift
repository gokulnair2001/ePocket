//
//  AddFriendViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 03/08/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNoField: UITextField!
    @IBOutlet var imageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButton(_ sender: Any) {
        
        if (nameField.text != "" && phoneNoField.text != ""){
            
            if phoneNoField.text?.count == 10 {
                nameArray.append(nameField.text!)
                noArray.append(phoneNoField.text!)
                phoneNoField.text = ""
                nameField.text = ""
                
              
                
                self.dismiss(animated: true, completion: nil)
                
            }else{
                let alert = UIAlertController(title: "Error", message: "Phone Number Must be of 10 digits", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                
                present(alert, animated: true)
            }
            
            
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Field Is Empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            present(alert, animated: true)
        }
        
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
