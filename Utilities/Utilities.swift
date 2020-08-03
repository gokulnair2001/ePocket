//
//  Utilities.swift
//  ePocket
//
//  Created by Gokul Nair on 31/07/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import Foundation

class utilities {
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
