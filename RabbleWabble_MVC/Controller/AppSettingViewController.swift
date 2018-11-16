//
//  AppSettingViewController.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/1.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class AppSettingViewController: UIViewController {
    //MARK: -Properties
    public let appSettings = AppSetting.shared
    fileprivate let cellId = "cellID"
    
    
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupViews()
        setupDismissBarButtonItem()
    }
}

extension AppSettingViewController{
    fileprivate func registerCell(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func setupViews(){
        view.addSubview(tableView)
        tableView.fullAnchor(superView: view)
    }
    
    fileprivate func setupDismissBarButtonItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "dismiss", style: .plain, target: self, action: #selector(handleDismissButton(sender:)))
    }
    
    @objc func handleDismissButton(sender: Any){
        navigationController?.dismiss(animated: true, completion: nil)
    }
}


extension AppSettingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionStrategyType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        cell.textLabel?.text = questionStrategyType.title()
        
        if appSettings.questionStrategyType == questionStrategyType{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
}

extension AppSettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        appSettings.questionStrategyType = questionStrategyType
        tableView.reloadData()
    }
}
