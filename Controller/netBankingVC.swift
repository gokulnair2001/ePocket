//
//  netBankingVC.swift
//  ePocket
//
//  Created by Gokul Nair on 21/08/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit

class netBankingVC: UIViewController {
    
    var arrImgData = [UIImage]()
     var labelText = [String]()
     var imageURL = [String]()
    

    @IBOutlet weak var collectionView: UICollectionView!
    
     let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       collectionView.delegate = self
                    collectionView.dataSource = self
                    
                    arrImgData = [#imageLiteral(resourceName: "5.png"),#imageLiteral(resourceName: "2.png"),#imageLiteral(resourceName: "4.png"),#imageLiteral(resourceName: "1.png"),#imageLiteral(resourceName: "3.png"),#imageLiteral(resourceName: "6.png"),#imageLiteral(resourceName: "9.png"),#imageLiteral(resourceName: "7.png"),#imageLiteral(resourceName: "images"),#imageLiteral(resourceName: "1200x630wa")]
                    labelText = ["Kotak","ICICI","Axis","HDFC","PNB","RBL","Fedral","Bandhan","Yes","KVB"]
                    imageURL = ["https://www.kotak.com/en.html","https://www.icicibank.com","https://www.axisbank.com","https://www.hdfcbank.com","https://www.pnbindia.in","https://www.rblbank.com","https://www.federalbank.co.in","https://www.bandhanbank.com","https://www.yesbank.in","https://www.kvb.co.in"]
    }
    

    
    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    
}

extension netBankingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NBCollectionViewCell
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
extension netBankingVC: UICollectionViewDelegateFlowLayout{
    
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
