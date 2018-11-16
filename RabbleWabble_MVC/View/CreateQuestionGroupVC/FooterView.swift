//
//  FooterView.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

public protocol FooterViewDelegate: class{
    func footerView(view: UIView, didAddQuestion: UIButton)
}


public class FooterView: BasicView {
    weak var delegate: FooterViewDelegate?
    
    lazy var addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(addQuestion(sender:)), for: .touchUpInside)
        btn.setImage(UIImage(named: "ic_circle_plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    @objc func addQuestion(sender: UIButton){
        delegate?.footerView(view: self, didAddQuestion: sender)
    }
    
    override public func setupViews() {
        setupUI()
    }
}

extension FooterView{
    fileprivate func setupUI(){
        addSubview(addButton)
        addButton.centerAnchor(superView: self, width: 80, height: 80)
    }
}
