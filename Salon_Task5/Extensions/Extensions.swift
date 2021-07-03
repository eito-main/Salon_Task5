//
//  Extensions.swift
//  Salon_Task5
//
//  Created by 相良 詠斗 on 2021/07/03.
//

import Foundation
import UIKit

extension Notification.Name {
    static let notifyName = Notification.Name("DivisionModel")
}

extension UIAlertController {
    static func okAlert(title: String?,
                        message: String?,
                        okHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: okHandler))
        return alert
    }
}

extension UIViewController {
    func present(_ alert: UIAlertController, completion: (() -> Void)? = nil) {
        present(alert, animated: true, completion: completion)
    }
}
