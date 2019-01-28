//
//  UIViewController+AlertExt.swift
//  PopularMovieBrowser
//
//  Created by Nicole Hinckley on 1/28/19.
//  Copyright © 2019 Nicole Hinckley. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
