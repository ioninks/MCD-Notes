//
//  Category.swift
//  MCD-Notes
//
//  Created by Konstantin Ionin on 28.02.2020.
//  Copyright © 2020 Konstantin Ionin. All rights reserved.
//

import UIKit

extension Category {
    
    var color: UIColor? {
        get {
            guard let hex = colorAsHex else {
                return nil
            }
            return UIColor(hex: hex)
        }
        
        set(newColor) {
            if let newColor = newColor {
                colorAsHex = newColor.toHex
            }
        }
    }
}
