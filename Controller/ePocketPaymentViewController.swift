//
//  ePocketPaymentViewController.swift
//  ePocket
//
//  Created by Gokul Nair on 30/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit

class ePocketPaymentViewController: UIViewController {

      let haptic = haptickFeedback()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func doneBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
        haptic.haptiFeedback1()
    }
    
}
