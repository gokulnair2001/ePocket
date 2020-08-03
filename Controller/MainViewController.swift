//
//  ViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 29/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

//var nameArray = [String]()
//var noArray = [String]()

var nameArray = ["Gokul","Charvin","Vraj","Priya","Pearl","Heet"]
var noArray = ["1234567898","1234567898","1234567898","1234567898","1234567898","1234567898"]

var image = [""]
class MainViewController: UIViewController {
    
    let haptic = haptickFeedback()
    let db = Firestore.firestore()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    
    var mobileNo:String! = ""
    
    
    @IBOutlet weak var CARDIMAGE: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card1v: UIView!
    @IBOutlet weak var card2v: UIView!
    @IBOutlet weak var card3v: UIView!
    @IBOutlet weak var card4v: UIView!
    
    @IBOutlet weak var mainCardAccNo: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        loadData()
        //Shadow Effect Code
        
        CARDIMAGE.layer.cornerRadius = 20
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cardView.layer.shadowOpacity = 0.9
        cardView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        cardView.layer.shadowRadius = 25
        
        CARDIMAGE.clipsToBounds = true
        
        
        card1.layer.cornerRadius = 10
        card2.layer.cornerRadius = 10
        card3.layer.cornerRadius = 10
        card4.layer.cornerRadius = 10
        
        card1v.layer.cornerRadius = 20
        card1v.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        card1v.layer.shadowOpacity = 0.5
        card1v.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        card1v.layer.shadowRadius = 10
        
        card2v.layer.cornerRadius = 20
        card2v.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        card2v.layer.shadowOpacity = 0.5
        card2v.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        card2v.layer.shadowRadius = 10
        
        card3v.layer.cornerRadius = 20
        card3v.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        card3v.layer.shadowOpacity = 0.5
        card3v.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        card3v.layer.shadowRadius = 10
        
        card4v.layer.cornerRadius = 20
        card4v.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        card4v.layer.shadowOpacity = 0.5
        card4v.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        card4v.layer.shadowRadius = 10
        
        card1.clipsToBounds = true
        card2.clipsToBounds = true
        card3.clipsToBounds = true
        card4.clipsToBounds = true
        
        
    }
    
    @IBAction func toReminder(_ sender: Any) {
        self.performSegue(withIdentifier: "toreminder", sender: nil)
        haptic.haptiFeedback1()
    }
    
    
    @IBAction func showCard(_ sender: Any) {
        performSegue(withIdentifier: "show", sender: nil)
        haptic.haptiFeedback2()
    }
    
    @IBAction func onlinePayment(_ sender: Any) {
        performSegue(withIdentifier: "onlinePayment", sender: nil)
        haptic.haptiFeedback2()
    }
    
    @IBAction func paymentgateway(_ sender: Any) {
        performSegue(withIdentifier: "paymentgateway", sender: nil)
        haptic.haptiFeedback2()
    }
    
    @IBAction func subPayment(_ sender: Any) {
        performSegue(withIdentifier: "subscrip", sender: nil)
        haptic.haptiFeedback2()
    }
    
    @IBAction func ePocketPayment(_ sender: Any) {
        performSegue(withIdentifier: "ePocket", sender: nil)
        haptic.haptiFeedback2()
    }
    
    
    @IBAction func newFriend(_ sender: Any) {
        self.performSegue(withIdentifier: "new", sender: nil)
        collectionView.reloadData()
    }
    
    
}


//MARK:- LOGOUT Section Code

extension MainViewController{
    
    @IBAction func logOutBtn(_ sender: Any) {
        
        let actionController = UIAlertController(title: nil, message: "Are You sure You want to SignOut", preferredStyle: .actionSheet)
        actionController.addAction(UIAlertAction(title: "SignOut", style: .default, handler: { (_) in
            self.signout()
        }))
        actionController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionController, animated: true,completion: nil)
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            
        }
        catch let signouterror as NSError {
            print("error found:\(signouterror)")
        }
    }
    
}

//MARK:- To retrieve the data

extension MainViewController {
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
                    self.userName.text = document["Full Name"] as? String
                    self.mainCardAccNo.text = document["Account No"] as? String
                    self.mobileNo = document["Phone No"] as? String
                    // print(self.mobileNo!)
                    // let pass = document.documentID
                    //self.performSegue(withIdentifier: "show", sender: pass)
                } else {
                    print("Document does not exist")
                    let popUp = UIAlertController(title: nil, message: "Document does not exist", preferredStyle: .alert)
                    popUp.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                }
                
            }
        }
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContactsCollectionViewCell
        
        cell.nameView.text = nameArray[indexPath.row]
        cell.phoneNolbl.text = noArray[indexPath.row]
        
        cell.layer.cornerRadius = 10
        
        cell.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.9
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 1,height: 0)
        
       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = noArray[indexPath.row]
        if let phoneUrl = URL(string: "tel:\(number)"){
                   if UIApplication.shared.canOpenURL(phoneUrl){
                       UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
                    haptic.haptiFeedback1()
                   }else{
                    return
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
