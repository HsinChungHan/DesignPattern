//
//  QuestionGroupCaretaker.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/3.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation

public final class QuestionGroupCaretaker{
    //MARK: -Properties
    private let fileName = "QuestionGroupData"
    public var questionGroups: [QuestionGroup] = []
    public var selectedQuestionGroup: QuestionGroup!
    
    //MARK: Object Life Cycle
    public init(){
        do{
            try loadQuestionGroups()
        }catch let error{
            print("Failed to loadQuestionGroups() \(error)")
        }
    }
    
    private func loadQuestionGroups() throws{
        if let questionGroups = try? DiskCaretaker.retrive([QuestionGroup].self, from: fileName){
            //App一開始沒有存檔
            guard let questionGroups = questionGroups else {return}
            self.questionGroups = questionGroups
        }else{
            //Bundle.main可以raference到project的路徑
            let bundle = Bundle.main
            guard let url = bundle.url(forResource: fileName, withExtension: "json") else {return}
            do{
                //從Bundle.main loading完questionGroups後，再把它存到fileManager
                self.questionGroups = try DiskCaretaker.retrive([QuestionGroup].self, from: url)
                try save()
            }catch let error{
                print(error.localizedDescription)
                throw error
            }
        }
    }
    
    public func save() throws{
        try DiskCaretaker.save(questionGroups, to: fileName)
    }
}
