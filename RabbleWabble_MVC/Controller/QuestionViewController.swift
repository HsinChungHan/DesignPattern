//
//  ViewController.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
public protocol QuestionViewControllerDelegate: class {
//    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int)
//
//    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup)
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy)
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy)
}



public class QuestionViewController: UIViewController {
    //MARK: -Strategy
    public var questionStrategy: QuestionStrategy? {
        didSet{
            guard let questionStrategy = questionStrategy  else {return}
            navigationItem.title = questionStrategy.title
        }
    }
    
    
    //MARK: -Instance Properties
    public weak var delegate: QuestionViewControllerDelegate?
//    public var questionIndex = 0
//    public var correctCount = 0
//    public var incorrectCount = 0
//    public var questionGroup: QuestionGroup? {
//        didSet{
//            guard let questionGroup = questionGroup else {return}
//            navigationItem.title = questionGroup.title
//            print(questionGroup.questions)
//        }
//    }
    
    lazy var questionView: QuestionView = {
       let view = QuestionView()
        view.delegate = self
        return view
    }()
    
    fileprivate lazy var questionIndexItem: UIBarButtonItem = {
       let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupQuestionView()
//        showQuestion()
        showQuestionByStrategy()
        setupCancelButton()
    }
}

extension QuestionViewController{
    fileprivate func setupQuestionView(){
        view.addSubview(questionView)
        questionView.fullAnchor(superView: view)
    }
    
    fileprivate func setupCancelButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ic_menu"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(handelCancelPressed(sender:)))
    }
    
    @objc func handelCancelPressed(sender: UIBarButtonItem){
        guard let questionStrategy = questionStrategy else {return}
//        delegate?.questionViewController(self, didCancel: questionGroup, at: questionIndex)
        delegate?.questionViewController(self, didCancel: questionStrategy)
    }
    
    
//    fileprivate func showQuestion(){
//        guard let questionGroup = questionGroup else {return}
//        let question = questionGroup.questions[questionIndex]
//        questionView.answerLabel.text = question.answer
//        questionView.promptLabel.text = question.prompt
//        questionView.hintLabel.text = question.hint
//
//        questionView.answerLabel.isHidden = true
//        questionView.hintLabel.isHidden = true
//
//        questionIndexItem.title = "\(questionIndex + 1) / \(questionGroup.questions.count)"
//    }
    
    
    fileprivate func showQuestionByStrategy(){
        guard let questionStrategy = questionStrategy else {return}
        let question = questionStrategy.currentQuestion()
        print(questionStrategy.currentQuestion())
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    
//    fileprivate func showNextQuestion(){
//        questionIndex += 1
//        guard let questionCount = questionGroup?.questions.count, questionIndex < questionCount else {
////            delegate?.questionViewController(self, didComplete: questionGroup!)
//            guard let questionStrategy = questionStrategy else {return}
//            delegate?.questionViewController(self, didComplete: questionStrategy)
//            return
//        }
////        showQuestion()
//        showQuestionByStrategy()
//    }
    
    fileprivate func showNextQuestion(){
        guard let questionStrategy = questionStrategy else {return}
        guard questionStrategy.advanceToNextQuestion() else{
            delegate?.questionViewController(self, didComplete: questionStrategy)
            return
        }
        showQuestionByStrategy()
    }
}

extension QuestionViewController: QuestionViewDelegate{
    func handleCorrect(_ sender: Any) {
        guard let question = questionStrategy?.currentQuestion(), let questionStrategy = questionStrategy else {return}
        questionStrategy.markQuestionCorrect(question)
        questionView.correctCountLabel.text = String(questionStrategy.correctCount)
        showNextQuestion()
    }
    
    func handelIncorrect(_ sender: Any) {
        guard let question = questionStrategy?.currentQuestion(), let questionStrategy = questionStrategy else {return}
        questionStrategy.markQuestionIncorrect(question)
        questionView.incorrectCountLabel.text = String(questionStrategy.incorrectCount)
        showNextQuestion()
    }
    
//    func handelIncorrect(_ sender: Any) {
//        incorrectCount += 1
//        print("inCorrectCount: ", incorrectCount)
//        questionView.incorrectCountLabel.text = "\(incorrectCount)"
//        showNextQuestion()
//    }
//
//    func handleCorrect(_ sender: Any) {
//        correctCount += 1
//        print("inCorrectCount: ", incorrectCount)
//        questionView.correctCountLabel.text = "\(correctCount)"
//        showNextQuestion()
//    }
    
    
}
