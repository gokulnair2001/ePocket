//
//  SignInViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 29/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var purpleLayer1: UIImageView!
    @IBOutlet weak var instaIm: UIImageView!
    @IBOutlet weak var linkIm: UIImageView!
    @IBOutlet weak var twitIm: UIImageView!
    
    let db = Firestore.firestore()
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailtextField.delegate = self
        passwordtextField.delegate = self
        
        authenticateUserAndConfigureView()
        
        purpleLayer1.layer.cornerRadius = 30
        
        
        instaIm.layer.cornerRadius = 10
        twitIm.layer.cornerRadius = 10
        linkIm.layer.cornerRadius = 10
        
        self.hideKeyboardWhenTappedAround()
        
        
        if core.shared.isNewUser() {
                   let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnBoardingViewController
                   present(vc, animated: true)
               }
    }
    
    //SignUp Button Action
    
    @IBAction func signUpBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "tosignUp", sender: nil)
        haptic.haptiFeedback1()
    }
    
    @IBAction func instaLink(_ sender: Any) {
         UIApplication.shared.open(URL(string: "https://www.instagram.com/_gokul_r_nair_/")! as URL, options: [:], completionHandler: nil)
         haptic.haptiFeedback1()
    }
    @IBAction func linkdeinLink(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/gokul-r-nair/")! as URL, options: [:], completionHandler: nil)
         haptic.haptiFeedback1()
    }
    @IBAction func twitterLink(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://twitter.com/GokulRN38554108")! as URL, options: [:], completionHandler: nil)
         haptic.haptiFeedback1()
    }
    
    
}

//MARK:- LogIn Action

extension SignInViewController: UITextFieldDelegate {
    
    @IBAction func logInBtn(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailtextField.text!, password: passwordtextField.text!){(user, error)
            in
            if error == nil
            {
                self.performSegue(withIdentifier: "toMainVC", sender: nil)
                self.haptic.haptiFeedback1()
                self.clear()
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .actionSheet)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    //MARK:- Function to clear textfield after log in
    
    func clear() {
        self.emailtextField.text?.removeAll()
        self.passwordtextField.text?.removeAll()
    }
    
}


//MARK:-  Authentication- FaceID/TouchID/textKey

extension SignInViewController {
    
    func authenticateUserAndConfigureView()
    {
        if Auth.auth().currentUser != nil{
            let context:LAContext = LAContext()
            
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
            {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Message") { (True, error) in
                    if True
                    {
                        
                        print("sucess")
                        DispatchQueue.main.async {
                            self.navigationController?.isNavigationBarHidden = true
                            
                            self.performSegue(withIdentifier: "toMainVC", sender: nil)
                            self.haptic.haptiFeedback1()
                            
                        }
                        
                    }
                    else
                    {
                        print(error!)
                    }
                }
            }else{
                print("Enter Your Auth ID")
            }
        }
        
    }
    
    
}

//MARK:- Keyboard Hide code
extension SignInViewController {
    
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }

        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}



//MARK:-  Onboarding Code

class core{
    
    static let shared = core()
    
    func isNewUser()->Bool {
        return !UserDefaults.standard.bool(forKey: "onboarding")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "onboarding")
    }
}

