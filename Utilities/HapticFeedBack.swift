//
//  HapticFeedBack.swift
//  ePocket
//
//  Created by Gokul Nair on 29/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import Foundation
import  AVKit


class haptickFeedback {
  
    func haptiFeedback1() {
    //print("haptick done")
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
    }
    
    func haptiFeedback2() {
    //print("haptick done")
    let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
}

