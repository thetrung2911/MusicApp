//
//  AlertHelper.swift
//  MusicApp
//
//  Created by Trung Le on 09/23/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    static func showAlert(message: String, viewController: UIViewController?){
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
