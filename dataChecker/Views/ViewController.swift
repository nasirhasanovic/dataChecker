//
//  ViewController.swift
//  dataChecker
//
//  Created by NasirHasanovic on 21. 1. 2022..
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var expressionField: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var matchingLabel: UILabel!
    
    private var viewModel = DataCheckerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreen()
        setBindings()
    }
    
    private func setScreen() {
        checkBtn.setTitle("Check expression", for: .normal)
        checkBtn.layer.cornerRadius = 8
        checkBtn.layer.borderWidth = 1
        checkBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func expressionChanged(_ sender: Any) {
        if let expression = expressionField.text{
            viewModel.updateExpression(expression: expression)
        }
    }
    
    @IBAction func checkTapp(_ sender: Any) {
        viewModel.compareExpressions()
    }
}

extension ViewController {
    func setBindings() {
        self.viewModel.matchedExpressions.bind{ [weak self] in
            if $0.isEmpty == false{
                self?.matchingLabel.text = "Matching data: \($0.joined(separator: ", "))"
            }
        }
    }
}
