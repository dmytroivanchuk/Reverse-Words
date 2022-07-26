//
//  ViewController.swift
//  Reverse Words
//
//  Created by Dmytro Ivanchuk on 22.07.2022.
//

import UIKit
import IQKeyboardManagerSwift

class ViewController: UIViewController {
    
    let stringModel = StringModel()
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var textField: UITextField!
    @IBOutlet var reversedStringLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.currentTitle == "Reverse" && textField.text != "" {
            reversedStringLabel.text = stringModel.reverseWords(in: textField.text)
            button.setTitle("Clear", for: .normal)
        } else if sender.currentTitle == "Clear" {
            button.setTitle("Reverse", for: .normal)
            button.isEnabled = false
            button.alpha = 0.6
            textField.text = ""
            reversedStringLabel.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.delegate = self
        
        textField.delegate = self
        textField.layer.addSublayer(createCALayer(color: .systemGray5))
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        button.layer.cornerRadius = 14
        button.setTitle("Reverse", for: .normal)
        button.isEnabled = false
        button.alpha = 0.6
    }
}

//MARK: - UITextField Methods

extension ViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text == "" {
            button.setTitle("Reverse", for: .normal)
            button.isEnabled = false
            button.alpha = 0.6
        } else {
            button.isEnabled = true
            button.alpha = 1
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.addSublayer(createCALayer(color: UIColor(named: "blueColor")!))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != "" else {
            return false
        }
        reversedStringLabel.text = stringModel.reverseWords(in: textField.text)
        button.setTitle("Clear", for: .normal)
        textField.layer.addSublayer(createCALayer(color: .systemGray5))
        textField.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
        textField.layer.addSublayer(createCALayer(color: .systemGray5))
    }
    
    private func createCALayer(color: UIColor) -> CALayer {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = color.cgColor
        return bottomLine
    }
}

//MARK: - UINavigationBarDelegate Methods

extension ViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        .topAttached
    }
}

