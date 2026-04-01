//
//  Extension+VC.swift
//  Bank App
//
//  Created by Egor on 01.04.2026.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ок", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
