//
//  SignUpViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 29/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import Firebase
import MessageUI


class SignUpViewController: UIViewController,UITextFieldDelegate, UINavigationControllerDelegate {
    
    
    let db = Firestore.firestore()
    
    let haptic = haptickFeedback()
    
    let imagePicker = UIImagePickerController()
    //MARK:- IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var accountNo: UITextField!
    @IBOutlet weak var profileImageIP: UIImageView!
    @IBOutlet weak var purpleLayer1: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purpleLayer1.layer.cornerRadius = 30
        purpleLayer1.layer.borderWidth = 1
        purpleLayer1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
       // imagePicker.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func message(_ sender: Any) {
        self.facingIssue()
        haptic.haptiFeedback1()
    }
   
    
}


//MARK:-  Validating my fields

extension SignUpViewController {
    func validateFields() -> String? {
        
        //Field Validating code
        
        if(nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && accountNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && numberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && confirmPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            return "Make Sure fields are not empty and full fills the criteria as mentioned"
        }
        // Email Validatinf Code
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if utilities.isPasswordValid(cleanedPassword) == false {
            return "Password must have one Lower and Upper Case one Number and One Symbol"
        }
        
        // Password validationg code
        if confirmPasswordTF.text != passwordTextField.text {
            return "Password and Confirm Password are not same"
        }
        
        //MobileNumber check
        if numberTextField.text!.count != 10 {
            return "Mobile Number Must Be Of 10 Digits"
        }
        
        //Account No Check
        
        if accountNo.text!.count != 16 {
            return "Account Number Must Be Of 16 Digits"
        }
        
        return nil
    }
}

//MARK:- signIn Functions

extension SignUpViewController{
    
    @IBAction func signInBtn(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            let alert = UIAlertController(title: "Check Your Fields", message: "\(error!)", preferredStyle: .actionSheet)
            
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            Auth.auth().createUser(withEmail: (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, password: (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!){
                (result , error) in
                //MARK:- MOST IMPORTANT LINE OF CODE TO LINK UID AND DOC.ID TO LINK BOTH OF THEM
                
                let UID = Auth.auth().currentUser!.uid
                let collection = self.db.collection(ePocket.FStore.collectionname).document(UID)
                
                if error == nil {
                    
                   
                    
                    if let name = self.nameTextField.text,
                        let phoneNo = self.numberTextField.text,
                        let accNo = self.accountNo.text,
                        let signInUser = Auth.auth().currentUser?.email{
                        
                        collection.setData([
                            
                            ePocket.FStore.emailId: signInUser,
                            ePocket.FStore.userName: name,
                            ePocket.FStore.number: phoneNo,
                            ePocket.FStore.accNo: accNo
                            ])
                        {
                            
                            (error) in
                            if let e = error {
                                print("There got some kind of issue,\(e)")
                            }
                            else{
                                //saveFIRStorageData()
                                print("Sucessfuly saved!!")
                                self.clear()
                            }
                        }
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "tomain", sender: nil)
                        self.clear()
                    }
                    
                }
                else
                {
                    let alertController = UIAlertController (title: "Error",
                                                             message: error?.localizedDescription,
                                                             preferredStyle: .actionSheet)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
        
        
    }
    
    
}







//MARK:- Utilities

extension SignUpViewController {
    
    //MARK:- CLEAR FIELD ONCE SIGNED IN
    
    func clear() {
        self.nameTextField.text?.removeAll()
        self.confirmPasswordTF.text?.removeAll()
        self.passwordTextField.text?.removeAll()
        self.emailTextField.text?.removeAll()
        self.numberTextField.text?.removeAll()
        self.accountNo.text?.removeAll()
    }
    
    //MARK:- keyBoard Utilities
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

//MARK:- Email Setup

extension SignUpViewController: MFMailComposeViewControllerDelegate{
    func facingIssue() {
        guard MFMailComposeViewController.canSendMail() else {
            
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["gokulnair.2001@gmail.com"])
        composer.setSubject("Facing Issue")
        composer.setMessageBody("Hi Gokul, I am facing an issue while signing Up the formalities", isHTML: false)
        
        present(composer, animated: true)
    }
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        case .saved:
            print("saved")
        case .sent:
            print("sent")
        @unknown default:
            print("other error")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

