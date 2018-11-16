//
//  MainViewController.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class SelectQuestionGroupViewController: UIViewController {
    
    //MARK: -Properties
//    public let questionGroup = QuestionGroup.allGroups()
    private let questionGroupCareTaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup]{
        return questionGroupCareTaker.questionGroups
    }
    
    
    
    fileprivate var selectedGroup: QuestionGroup?{
        get{
            return questionGroupCareTaker.selectedQuestionGroup
        }set{
            questionGroupCareTaker.selectedQuestionGroup = newValue
        }
    }
    fileprivate let appSetting = AppSetting.shared
    
    //MARK: -View Property
    lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        return tv
    }()
    
    //MARK: -View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Select Question Group"
        setupViews()
        registerCell()
        setupSettingButton()
        questionGroups.forEach { (questionGroup) in
            print("\(questionGroup.title): \ncorrect count: \(questionGroup.score.correctCount) \n incorrect count: \(questionGroup.score.incorrectCount)")
        }
    }
}

extension SelectQuestionGroupViewController{
    fileprivate func setupViews(){
        view.addSubview(tableView)
        tableView.fullAnchor(superView: view)
    }
    
    fileprivate func registerCell(){
        tableView.register(QuestionGroupCell.self, forCellReuseIdentifier: "cellID")
    }
    
    fileprivate func setupSettingButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ic_settings"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(handleSettingPressed(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(createNewQuestionGroup))
    }
    
    @objc func handleSettingPressed(sender: Any){
        let appSettingVC = AppSettingViewController()
        let naviVC = UINavigationController(rootViewController: appSettingVC)
        navigationController?.present(naviVC, animated: true, completion: nil)
    }
    
    @objc func createNewQuestionGroup(){
        let createNewQuestionGroupVC = CreateQuestionGroupViewController()
        createNewQuestionGroupVC.delegate = self
        let naviVC = UINavigationController(rootViewController: createNewQuestionGroupVC)
        navigationController?.present(naviVC, animated: true, completion: nil)
    }
}



extension SelectQuestionGroupViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let questionGroup = questionGroups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! QuestionGroupCell
        cell.titleLabel.text = questionGroup.title
        cell.subtitleLabel.text = "20 %"
        
        //MARK: -Observer Design Pattern
        //add observer
        questionGroup.score.runningPercentage.addObserver(cell, removeIfExist: true, options: [.initial, .new]) { [weak cell] (percentage, _) in
            DispatchQueue.main.async {
                cell?.subtitleLabel.text = String(format: "%.f %%", round(100 * percentage))
                print(String(format: "%.f %%", round(100 * percentage)))
            }
        }
        
        return cell
    }
    
    
}


extension SelectQuestionGroupViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedGroup = questionGroups[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionVC = QuestionViewController()
//        questionVC.questionStrategy = RandomQuestionStrategy(questionGroup: selectedGroup)
        questionVC.questionStrategy = appSetting.questionStrategy(for: questionGroupCareTaker)
        
        questionVC.delegate = self
        let naviVC = UINavigationController(rootViewController: questionVC)
        navigationController?.present(naviVC, animated: true, completion: nil)
    }
}


extension SelectQuestionGroupViewController: QuestionViewControllerDelegate{
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy) {
        navigationController?.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy) {
        navigationController?.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
//    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int) {
//        navigationController?.dismiss(animated: true, completion: nil)
//    }
//
//    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup) {
//        navigationController?.dismiss(animated: true, completion: nil)
//    }
}


extension SelectQuestionGroupViewController: CreateQuestionGroupViewControllerDeleate{
    
    func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController, created questionGroup: QuestionGroup) {
        questionGroupCareTaker.questionGroups.append(questionGroup)
        do{
            try questionGroupCareTaker.save()
        }catch let error{
            print("Failed to save new question group: \(error)")
        }
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
}
