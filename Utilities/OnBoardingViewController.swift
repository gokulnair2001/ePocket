//
//  OnBoardingViewController.swift
//  abseil
//
//  Created by Gokul Nair on 30/07/20.
//

import UIKit

class OnBoardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func continueBtn(_ sender: Any) {
        self.dismiss(animated:true)
               core.shared.setIsNotNewUser()
    }
    
}
