//
//  showCardViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 29/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class showCardViewController: UIViewController {
    
    @IBOutlet weak var CARDIMAGE: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var AccountNo: UILabel!
    @IBOutlet weak var holdername: UILabel!
    @IBOutlet weak var mainCardNo: UILabel!
    @IBOutlet weak var cardHolder: UILabel!
    @IBOutlet weak var mobileNo: UILabel!
    
    let db = Firestore.firestore()
    
    let haptic = haptickFeedback()
    let main = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CARDIMAGE.layer.cornerRadius = 20
        userImage.layer.cornerRadius = 10
       
        loadData()
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- reminder Button
    
    @IBAction func reminderBtn(_ sender: Any) {
        performSegue(withIdentifier: "detailtoreminder", sender: nil)
    }
    //MARK:- report Button
    
    @IBAction func reportBtn(_ sender: Any) {
        self.reportProblem()
        haptic.haptiFeedback2()
    }
    //MARK:- support call btn
    
    @IBAction func supportCall(_ sender: Any) {
        if let phoneUrl = URL(string: "tel://012345678"){
            if UIApplication.shared.canOpenURL(phoneUrl){
                UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
            }else{
                let alertController = UIAlertController(title: nil, message: "Your Device don't support Call", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
        }
        
    }
    
    @IBAction func paymentButton(_ sender: Any) {
   
        
        
        let alertController = UIAlertController(title: "Payment Mode", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Net Banking", style: .default, handler: { action in
            self.performSegue(withIdentifier: "nb", sender: self)
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Payment Gateway", style: .default, handler: { action in
            self.performSegue(withIdentifier: "pg", sender: self)
        }))
        
        alertController.addAction(UIAlertAction(title: "Subscription Payments", style: .default, handler: { action in
            self.performSegue(withIdentifier: "sp", sender: self)
        }))
        
        alertController.addAction(UIAlertAction(title: "ePocket Payment", style: .default, handler: { action in
            self.performSegue(withIdentifier: "ep", sender: self)
        }))
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        
         present(alertController, animated:true)
    }
    
    
    
}

//MARK:- Report email code

extension showCardViewController: MFMailComposeViewControllerDelegate {
    
    func reportProblem() {
        guard MFMailComposeViewController.canSendMail() else {
            
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["gokulnair.2001@gmail.com"])
        composer.setSubject("Report Problem!")
        composer.setMessageBody("Hi Gokul, I want to report a problem in ePocket!", isHTML: false)
        
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

extension showCardViewController {
    func loadData() {
        let userID = Auth.auth().currentUser!.uid
        db.collection(ePocket.FStore.collectionname).document(userID).addSnapshotListener { (querySnapshot, error) in
            
            if error != nil {
                
                let popUp = UIAlertController(title: nil, message: "\(error!)", preferredStyle: .alert)
                popUp.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
            }
                
            else {
                if let document = querySnapshot, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    self.holdername.text = document["Full Name"] as? String
                    self.AccountNo.text = userID
                    self.cardHolder.text = document["Full Name"] as? String
                    self.mainCardNo.text = document["Account No"] as? String
                    self.mobileNo.text = document["Phone No"] as? String
                } else {
                    print("Document does not exist")
                    let popUp = UIAlertController(title: nil, message: "Document does not exist", preferredStyle: .alert)
                    popUp.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                }
                
            }
        }
        
    }
}


