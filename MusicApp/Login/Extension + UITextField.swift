//
//  Extension + UITextField.swift
//  MusicApp
//
//  Created by Trung Le on 09/23/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setBottomBorder(color: CGColor,height: Double){
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: height)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
