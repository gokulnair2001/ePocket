//
//  SunscriptionViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 30/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    var arrImgData = [UIImage]()
    var labelText = [String]()
    var imageURL = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        arrImgData = [#imageLiteral(resourceName: "Apple-TV-app-icon-1024x1024"),#imageLiteral(resourceName: "610LDzZhsUL"),#imageLiteral(resourceName: "prime"),#imageLiteral(resourceName: "9efdc7c6e61584b7c811a374be820f07"),#imageLiteral(resourceName: "akksdhkahdkahd_nT3M8BY"),#imageLiteral(resourceName: "25231"),#imageLiteral(resourceName: "C_j1HJ5XoAAR7c5"),#imageLiteral(resourceName: "174857"),#imageLiteral(resourceName: "MX-Player-For-Android_1556780472768"),#imageLiteral(resourceName: "f6974e017d3f6196c4cbe284ee3eaf4e"),#imageLiteral(resourceName: "1200px-Spotify_logo_without_text.svg"),#imageLiteral(resourceName: "tinder-logo"),#imageLiteral(resourceName: "YouTubeMusic_Logo"),#imageLiteral(resourceName: "20228")]
        labelText = ["Apple tv","Amazon Music","Amazon Prime","Bumble","Disney +","GitHub","iTune","Linkdein","MX Player","Netflix","Spotify","Tinder","YT Music","XBox"]
        imageURL = ["https://www.apple.com/in/apple-tv-plus/","https://www.amazon.in/music/prime?ref_=dmm_acq_marin_d_bra%7Cm_jkBWTRVw-dc_c_335004885047","https://www.primevideo.com","https://bumble.com/en-in/","https://www.hotstar.com/in","https://github.com","https://www.apple.com/in/itunes/","https://www.linkedin.com","https://www.mxplayer.in","https://www.netflix.com/in/","https://www.spotify.com/in/","https://tinder.com","https://www.youtube.com/musicpremium","https://www.xbox.com/en-IN/"]
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    
    
}

extension SubscriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SUBCollectionViewCell
        cell.imageView.image = arrImgData[indexPath.row]
        cell.lblText.text = labelText[indexPath.row]
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
        }
    }
}


extension SubscriptionViewController: UICollectionViewDelegateFlowLayout{
    
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
