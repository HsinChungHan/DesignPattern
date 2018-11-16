//
//  GroupTableViewCell.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

public protocol GroupTableViewCellDelegate: class{
    func groupTableViewCell(_ cell: UITableViewCell, titleTextFieldDidChange text: String)
}


public class GroupTableViewCell: BasicTableViewCell {
    weak var delegate: GroupTableViewCellDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Title"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var titleTextField: UITextField = {
       let textField = UITextField()
        textField.text = "Title"
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 1.0
        textField.clipsToBounds = true
        textField.addTarget(self, action: #selector(titleTextFieldDidChange(sender:)), for: .editingChanged)
        return textField
    }()
    
    @objc func titleTextFieldDidChange(sender: Any){
        print((sender as! UITextField).text!)
        delegate?.groupTableViewCell(self, titleTextFieldDidChange: (sender as! UITextField).text!)
    }
    
    override func setupViews() {
        setupUI()
    }

}

extension GroupTableViewCell{
    fileprivate func setupUI(){
        addSubview(titleLabel)
        addSubview(titleTextField)
        titleLabel.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 300, height: 20)
        titleTextField.anchor(top: titleLabel.bottomAnchor, bottom: nil, left: titleLabel.leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 20, width: 0, height: 30)
    }
}

extension GroupTableViewCell: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
