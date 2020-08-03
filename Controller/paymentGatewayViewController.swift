//
//  paymentGatewayViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 30/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit

class paymentGatewayViewController: UIViewController {

    var arrImgData = [UIImage]()
    var labelText = [String]()
    var imageURL = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        arrImgData = [#imageLiteral(resourceName: "Google-Pay-Logo-Icon-PNG"),#imageLiteral(resourceName: "og__dq5nejr4bg02_image"),#imageLiteral(resourceName: "AmazonPayLogo-543"),#imageLiteral(resourceName: "phone-pe"),#imageLiteral(resourceName: "bhim-3-69845"),#imageLiteral(resourceName: "2-2-paypal-logo-transparent-png"),#imageLiteral(resourceName: "Paytm-Logo-1200x1200"),#imageLiteral(resourceName: "Screen-Shot-2020-01-31-at-3.54.58-PM"),#imageLiteral(resourceName: "st,small,507x507-pad,600x600,f8f8f8"),#imageLiteral(resourceName: "Venmo-Color-900x900")]
        labelText = ["GPay","Apple Pay","Amazon Pay","Phone Pe","BHIM","PayPal","Paytm","Samsung Pay","Zelle","Venmo"]
        imageURL = ["https://pay.google.com/intl/en_in/about/","https://www.apple.com/apple-pay/","https://www.amazon.in/gp/sva/dashboard","https://www.phonepe.com","https://www.bhimupi.org.in","https://www.paypal.com","https://www.samsung.com/in/samsung-pay/","https://www.zellepay.com","https://venmo.com"]
        
    }
    
    @IBAction func doneBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    

}

extension paymentGatewayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PGCollectionViewCell
        cell.imageView.image = arrImgData[indexPath.row]
        cell.nameLbl.text = labelText[indexPath.row]
        cell.layer.cornerRadius = 10
        
        cell.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.9
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 0,height: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let urlString = self.imageURL[indexPath.row]
        if let url = URL(string: urlString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            haptic.haptiFeedback2()
        }else{
           return
        }
    }

}
extension paymentGatewayViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
         return CGSize(width: 180, height: 230)

     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 20
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 2
     }
    
}
