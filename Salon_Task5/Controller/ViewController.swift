//
//  ViewController.swift
//  Salon_Task5
//
//  Created by 相良 詠斗 on 2021/07/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!

    @IBAction func calculateButtonAction(_ sender: Any) {

        let numbers = checkNumbers(textFields: textFields)
        guard let checkNumbers = numbers else { return }
        divisionModel.division(checkNumbers[0], checkNumbers[1])
    }

    private let divisionModel = DivisionModel()
    private var textFields: [UITextField] {
        [firstTextField, secondTextField]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        divisionModel.notificationCenter.addObserver(
            forName: .didChangeDivisionModelResult,
            object: nil,
            queue: OperationQueue.main,
            using: { [weak self] notification in
                if let result = notification.object as? Double {
                    self?.resultLabel.text = String(result)
                }
            }
        )

        textFields.forEach { $0.keyboardType = .numberPad }
    }

    func checkNumbers(textFields:[UITextField]) -> [Int]? {

        let numberFormatter = NumberFormatter()

        let numbers = textFields.map { numberFormatter.number(from: $0.text ?? "")?.intValue }

        switch (numbers[0], numbers[1]) {
        case (nil, _):
            present(.okAlert(title: "課題5", message: "割られる数を入力してください"))
            return nil

        case (_, nil):
            present(.okAlert(title: "課題5", message: "割る数を入力してください"))
            return nil

        case (_, 0):
            present(.okAlert(title: "課題5", message: "割る数には0を入力しないでください"))
            return nil

        case (let number1?, let number2?):
            return [number1, number2]

        }
    }
}
