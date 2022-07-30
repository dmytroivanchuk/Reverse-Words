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
    @IBOutlet var mainTextField: UITextField!
    @IBOutlet var defaultSegmentLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var reversedStringLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    private var textToIgnoreTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Text to ignore"
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.delegate = self
        
        mainTextField.delegate = self
        mainTextField.layer.addSublayer(createCALayer(color: .systemGray5))
        mainTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        mainTextField.accessibilityIdentifier = "mainTextField"
        
        textToIgnoreTextField.delegate = self
        textToIgnoreTextField.layer.addSublayer(createCALayer(color: .systemGray5))
        textToIgnoreTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textToIgnoreTextField.accessibilityIdentifier = "textToIgnoreTextField"
        
        reversedStringLabel.accessibilityIdentifier = "reversedStringLabel"
        
        button.layer.cornerRadius = 14
        button.isEnabled = false
        button.alpha = 0.6
        button.accessibilityIdentifier = "button"
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        textToIgnoreTextField.layer.addSublayer(createCALayer(color: .systemGray5))
        
        if sender.selectedSegmentIndex == 0 {
            textToIgnoreTextField.removeFromSuperview()
            view.addSubview(defaultSegmentLabel)
            addConstrains(to: defaultSegmentLabel)
            reversedStringLabel.text = stringModel.reverseWords(in: mainTextField.text)
        
        } else if sender.selectedSegmentIndex == 1 {
            defaultSegmentLabel.removeFromSuperview()
            view.addSubview(textToIgnoreTextField)
            addConstrains(to: textToIgnoreTextField)
            reversedStringLabel.text = stringModel.reverseWords(in: mainTextField.text, ignoring: textToIgnoreTextField.text)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        mainTextField.text = ""
        mainTextField.layer.addSublayer(createCALayer(color: .systemGray5))
        
        textToIgnoreTextField.text = ""
        textToIgnoreTextField.layer.addSublayer(createCALayer(color: .systemGray5))
        
        reversedStringLabel.text = ""
        
        button.isEnabled = false
        button.alpha = 0.6
    }
    
    private func addConstrains(to item: NSObject) {
        var constrains = [NSLayoutConstraint]()
        
        if item == textToIgnoreTextField {
            constrains.append(NSLayoutConstraint(item: textToIgnoreTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 400 / 844, constant: 0))
            constrains.append(textToIgnoreTextField.leadingAnchor.constraint(equalTo: mainTextField.leadingAnchor))
            constrains.append(textToIgnoreTextField.trailingAnchor.constraint(equalTo: mainTextField.trailingAnchor))
            constrains.append(textToIgnoreTextField.heightAnchor.constraint(equalTo: mainTextField.heightAnchor))
        
        } else if item == defaultSegmentLabel {
            constrains.append(NSLayoutConstraint(item: defaultSegmentLabel!, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 400 / 844, constant: 0))
            constrains.append(defaultSegmentLabel.leadingAnchor.constraint(equalTo: mainTextField.leadingAnchor))
            constrains.append(defaultSegmentLabel.trailingAnchor.constraint(equalTo: mainTextField.trailingAnchor))
            constrains.append(defaultSegmentLabel.heightAnchor.constraint(equalTo: mainTextField.heightAnchor))
        }
        
        NSLayoutConstraint.activate(constrains)
    }
}

//MARK: - UITextField Methods

extension ViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard textField != textToIgnoreTextField else {
            reversedStringLabel.text = stringModel.reverseWords(in: mainTextField.text, ignoring: textToIgnoreTextField.text)
            return
        }
        if textField.text == "" {
            button.isEnabled = false
            button.alpha = 0.6
            reversedStringLabel.text = ""
        } else {
            button.isEnabled = true
            button.alpha = 1
            reversedStringLabel.text = stringModel.reverseWords(in: textField.text, ignoring: segmentedControl.selectedSegmentIndex == 0 ? nil : textToIgnoreTextField.text)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mainTextField {
            mainTextField.layer.addSublayer(createCALayer(color: UIColor(named: "blueColor")!))
            textToIgnoreTextField.layer.addSublayer(createCALayer(color: .systemGray5))
        
        } else if textField == textToIgnoreTextField {
            mainTextField.layer.addSublayer(createCALayer(color: .systemGray5))
            textToIgnoreTextField.layer.addSublayer(createCALayer(color: UIColor(named: "blueColor")!))
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != "" else {
            return false
        }
        textField.layer.addSublayer(createCALayer(color: .systemGray5))
        textField.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainTextField.endEditing(true)
        mainTextField.layer.addSublayer(createCALayer(color: .systemGray5))
        
        textToIgnoreTextField.endEditing(true)
        textToIgnoreTextField.layer.addSublayer(createCALayer(color: .systemGray5))
    }
    
    private func createCALayer(color: UIColor) -> CALayer {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: mainTextField.frame.height - 1, width: mainTextField.frame.width, height: 1.0)
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

