//
//  CreateQuestionGroupViewController.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

public enum CreateQuestionGroupViewControllerCellId: Int, CaseIterable{
    case group
    case question
    
    //MARK: -Insyance Methods
    public func cellId() -> String{
        switch self {
        case .group :
            return "GroupCellId"
        case .question:
            return "QuestionCellId"
        }
    }
}

public protocol CreateQuestionGroupViewControllerDeleate {
    func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController)
    func saveQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController, created questionGroup: QuestionGroup)
}



public class CreateQuestionGroupViewController: UIViewController {
    public var delegate: CreateQuestionGroupViewControllerDeleate?
    
    public let questionGroupBuilder = QuestionGroupBuilder()
    
    let groupCellId = CreateQuestionGroupViewControllerCellId.allCases[0].cellId()
    let questionCellId = CreateQuestionGroupViewControllerCellId.allCases[1].cellId()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupTableView()
        setNavigation()
    }
    
}



extension CreateQuestionGroupViewController{
    fileprivate struct CellIdentifiers{
        fileprivate static let groupCellId = "GroupCellId"
        fileprivate static let questionCellId = "questionCellId"
    }
    
    
    fileprivate func registerCell(){
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.groupCellId)
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.questionCellId)
    }
    
    fileprivate func setupTableView(){
        view.addSubview(tableView)
        tableView.fullAnchor(superView: view)
    }
    
    fileprivate func setNavigation(){
        navigationItem.title = "New Question Group"
        let cancelBarItem = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(cancelButton(sender:)))
        navigationItem.leftBarButtonItem = cancelBarItem
        let saveBarItem = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveButton(sender:)))
        navigationItem.rightBarButtonItem = saveBarItem
    }
    
    @objc func cancelButton(sender: Any){
        delegate?.createQuestionGroupViewControllerDidCancel(self)
//        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButton(sender: Any){
        do{
            let questionGroup = try questionGroupBuilder.build()
            delegate?.saveQuestionGroupViewController(self, created: questionGroup)
        }catch _ {
            displayMissingInputsAlert()
        }
        
        
    }
    
    public func displayMissingInputsAlert() {
        let alert = UIAlertController(
            title: "Missing Inputs",
            message: "Please provide all non-optional values \(MissingError.missing)",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    public enum MissingError: String, Swift.Error{
        case missing
    }
    
}



extension CreateQuestionGroupViewController: UITableViewDelegate, UITableViewDataSource{
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroupBuilder.questions.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0{
            return groupCell(from:tableView, for: indexPath)
        }else{
            return questionCell(from: tableView, for: indexPath)
        }
    }
    
    fileprivate func groupCell(from tableView: UITableView
        , for indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.groupCellId, for: indexPath) as! GroupTableViewCell
        cell.delegate = self
        cell.titleTextField.text = questionGroupBuilder.title
        return cell
    }
    
    fileprivate func questionCell(from tableView: UITableView
        , for indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.questionCellId, for: indexPath) as! QuestionTableViewCell
        cell.delegate = self
        let questionBuilder = self.questionBuilder(for: indexPath)
        cell.questionLabel.text = "Question \(indexPath.row)"
        cell.answerTextField.text = questionBuilder.answer
        cell.hintTextField.text = questionBuilder.hint
        cell.promptTextField.text = questionBuilder.prompt
        return cell
    }
    
    fileprivate func questionBuilder(for indexPath: IndexPath) -> QuestionBuilder{
        return questionGroupBuilder.questions[indexPath.row - 1]
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        default:
            return 180
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footeriew = FooterView()
        footeriew.delegate = self
        return footeriew
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}


extension CreateQuestionGroupViewController: GroupTableViewCellDelegate{
    public func groupTableViewCell(_ cell: UITableViewCell, titleTextFieldDidChange text: String) {
        print("text is \(text)")
        questionGroupBuilder.title = text
    }
    
    
}

extension CreateQuestionGroupViewController: QuestionTableViewCellDelegate{
    fileprivate func questionBuilder(for cell: UITableViewCell) -> QuestionBuilder{
        let indexPath = tableView.indexPath(for: cell)!
        return self.questionBuilder(for: indexPath)
    }
    
    
    public func questionTableViewCell(_ cell: QuestionTableViewCell, answerTextDidChange text: String) {
        questionBuilder(for: cell).answer = text
    }
    
    public func questionTableViewCell(_ cell: QuestionTableViewCell, promptTextDidChange text: String) {
        questionBuilder(for: cell).prompt = text
    }
    
    public func questionTableViewCell(_ cell: QuestionTableViewCell, hintTextDidChange text: String) {
        questionBuilder(for: cell).hint = text
    }
    
    
}


extension CreateQuestionGroupViewController: FooterViewDelegate{
    public func footerView(view: UIView, didAddQuestion: UIButton) {
        questionGroupBuilder.addNewQuestion()
        let indexPath = IndexPath(row: questionGroupBuilder.questions.count, section: 0)
        print(indexPath.count)
        tableView.insertRows(at: [indexPath], with: .top)
    }
    
    
}
