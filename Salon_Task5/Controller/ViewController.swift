//
//  ViewController.swift
//  Salon_Task5
//
//  Created by 相良 詠斗 on 2021/07/03.
//

import UIKit

private enum Discrimination {
    case firstTextFieldIsEmpty
    case secondTextFieldIsEmpty
    case secondTextFieldIsZero
    case success

    init(firstNumber: Int?,secondNumber: Int?){

        if firstNumber == nil {
            self = .firstTextFieldIsEmpty

        } else if secondNumber == nil {
            self = .secondTextFieldIsEmpty

        } else if secondNumber == 0 {
            self = .secondTextFieldIsZero

        } else {
            self = .success

        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

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
            self,
            selector: #selector(self.handleResultLabelChange(_:)),
            name: .notifyName,
            object: nil
        )

        textFields.forEach { $0.keyboardType = .numberPad }
    }

    @objc private func handleResultLabelChange(_ notification: Notification) {

        if let result = notification.object as? Double {
            resultLabel.text = String(result)
        }
    }

    func checkNumbers(textFields:[UITextField]) -> [Int]? {

        let numberFormatter = NumberFormatter()

        let numbers = textFields.map { numberFormatter.number(from: $0.text ?? "")?.intValue }
        let discrimination = Discrimination(firstNumber: numbers[0], secondNumber: numbers[1])

        switch discrimination {
        case .firstTextFieldIsEmpty:
            present(.okAlert(title: "課題5", message: "割られる数を入力してください"))
            return nil

        case .secondTextFieldIsEmpty:
            present(.okAlert(title: "課題5", message: "割る数を入力してください"))
            return nil

        case .secondTextFieldIsZero:
            present(.okAlert(title: "課題5", message: "割る数には0を入力しないでください"))
            return nil

        case .success:
            return [numbers[0]!, numbers[1]!]

        }
    }
}
