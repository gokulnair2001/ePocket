//
//  File.swift
//  ePocket
//
//  Created by Gokul Nair on 02/08/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import Foundation
import UIKit

class buttonAnimation{
    
    static func flashAnimation(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        
       
    }
    
}
