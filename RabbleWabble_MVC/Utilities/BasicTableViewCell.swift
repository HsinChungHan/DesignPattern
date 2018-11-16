//
//  BasicTableViewCell.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

public class BasicTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupViews(){
        
    }
}
