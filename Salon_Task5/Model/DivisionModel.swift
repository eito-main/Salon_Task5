//
//  DivisionModel.swift
//  Salon_Task5
//
//  Created by 相良 詠斗 on 2021/07/03.
//

import Foundation

extension Notification.Name {
    static let didChangeDivisionModelResult = Notification.Name("didChangeDivisionModelResult")
}

class DivisionModel {

    let notificationCenter = NotificationCenter()
    private var result = 0.0 {
        didSet {
            notificationCenter.post(
                name: .didChangeDivisionModelResult,
                object: result
            )
        }
    }

    func division(_ num1: Int, _ num2: Int) {
        let answer = Double(num1) / Double(num2)
        result = floor(answer*100000)/100000
    }
}
