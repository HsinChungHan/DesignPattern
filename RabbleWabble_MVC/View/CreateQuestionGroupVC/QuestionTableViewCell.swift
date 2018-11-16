//
//  QuestionTableViewCell.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

public protocol QuestionTableViewCellDelegate: class{
    func questionTableViewCell(_ cell: QuestionTableViewCell, answerTextDidChange text: String)
    func questionTableViewCell(_ cell: QuestionTableViewCell, promptTextDidChange text: String)
    func questionTableViewCell(_ cell: QuestionTableViewCell, hintTextDidChange text: String)
}


public class QuestionTableViewCell: BasicTableViewCell{
    weak var delegate: QuestionTableViewCellDelegate?
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question1"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var promptTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Prompt"
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 1.0
        textField.clipsToBounds = true
        textField.addTarget(self, action: #selector(promptTextFieldDidChange(sender:)), for: .editingChanged)
        return textField
    }()
    
    @objc func promptTextFieldDidChange(sender: Any){
        delegate?.questionTableViewCell(self, promptTextDidChange: (sender as! UITextField).text!)
    }
    
    lazy var hintTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Hint"
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 1.0
        textField.clipsToBounds = true
        textField.addTarget(self, action: #selector(hintTextFieldDidChange(sender:)), for: .editingChanged)
        return textField
    }()
    
    @objc func hintTextFieldDidChange(sender: Any){
        delegate?.questionTableViewCell(self, hintTextDidChange: (sender as! UITextField).text!)
    }
    
    lazy var answerTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Answer"
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 1.0
        textField.clipsToBounds = true
        textField.addTarget(self, action: #selector(answerTextFieldDidChange(sender:)), for: .editingChanged)
        return textField
    }()
    
    @objc func answerTextFieldDidChange(sender: Any){
        delegate?.questionTableViewCell(self, answerTextDidChange: (sender as! UITextField).text!)
    }
    
    override func setupViews() {
        setupUI()
    }
}

extension QuestionTableViewCell{
    fileprivate func setupUI(){
        addSubview(questionLabel)
        addSubview(promptTextField)
        addSubview(hintTextField)
        addSubview(answerTextField)
        questionLabel.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 300, height: 20)
        promptTextField.anchor(top: questionLabel.bottomAnchor, bottom: nil, left: questionLabel.leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 20, width: 0, height: 30)
        hintTextField.anchor(top: promptTextField.bottomAnchor, bottom: nil, left: questionLabel.leftAnchor, right: promptTextField.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 30)
        answerTextField.anchor(top: hintTextField.bottomAnchor, bottom: nil, left: questionLabel.leftAnchor, right: promptTextField.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 30)
    }
}


extension QuestionTableViewCell: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
