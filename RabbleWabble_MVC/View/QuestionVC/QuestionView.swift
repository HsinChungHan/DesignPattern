//
//  QuestionView.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol QuestionViewDelegate: class {
    func handelIncorrect(_ sender: Any)
    func handleCorrect(_ sender: Any)
}


public class QuestionView: UIView{
    weak var delegate: QuestionViewDelegate?
    
    public let answerLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Answer"
        return label
    }()
    
    public let promptLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Prompt"
        return label
    }()
    
    public let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Hint"
        return label
    }()
    
    public lazy var xButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(handleIncorrect), for: .touchUpInside)
        btn.setImage(UIImage(named: "ic_circle_x")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    @objc func handleIncorrect(){
        delegate?.handelIncorrect(xButton)
    }
    
    public let incorrectCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    public lazy var checkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(handleCorrect), for: .touchUpInside)
        btn.setImage(UIImage(named: "ic_circle_check")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    @objc func handleCorrect(){
        delegate?.handleCorrect(checkButton)
    }
    
    public let correctCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setTapGestureRecognizer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupViews(){
        addSubview(promptLabel)
        promptLabel.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 60, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 60)
        
        addSubview(hintLabel)
        hintLabel.anchor(top: promptLabel.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 8, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 30)
        
        addSubview(answerLabel)
        answerLabel.anchor(top: hintLabel.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 8, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 60)
        
        addSubview(incorrectCountLabel)
        incorrectCountLabel.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 20, leftPadding: 60, rightPadding: 0, width: 40, height: 40)
        addSubview(xButton)
        xButton.anchor(top: nil, bottom: incorrectCountLabel.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 80, height: 80)
        xButton.centerXAnchor.constraint(equalTo: incorrectCountLabel.centerXAnchor).isActive = true
        
        addSubview(correctCountLabel)
        correctCountLabel.anchor(top: incorrectCountLabel.topAnchor, bottom: incorrectCountLabel.bottomAnchor, left: nil, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 60, width: 40, height: 40)
        addSubview(checkButton)
        checkButton.anchor(top: nil, bottom: correctCountLabel.topAnchor, left: nil, right: rightAnchor, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 80, height: 80)
        checkButton.centerXAnchor.constraint(equalTo: correctCountLabel.centerXAnchor).isActive = true
    }
    
    fileprivate func setTapGestureRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toogleAnswerLabels))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func toogleAnswerLabels(_ sender: Any){
        answerLabel.isHidden = !answerLabel.isHidden
        hintLabel.isHidden = !hintLabel.isHidden
    }
}
