//
//  MainTableViewCell.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class QuestionGroupCell: BasicTableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.black
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "10%"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    override func setupViews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        titleLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: nil, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 0, width: 500, height: 0)
        subtitleLabel.anchor(top: titleLabel.topAnchor, bottom: titleLabel.bottomAnchor, left: nil, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 5, width: 60, height: 0)
    }
}
