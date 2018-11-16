//
//  QuestionGroupBuilder.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
public class QuestionGroupBuilder{
    public var questions = [QuestionBuilder()]
    public var title = ""
    
    public func addNewQuestion(){
        let question = QuestionBuilder()
        questions.append(question)
    }
    
    public func removeQuestion(at index: Int){
        questions.remove(at: index)
    }
    
    public func build() throws -> QuestionGroup{
        guard title.count > 0 else {
            throw Error.missingTitle
        }
        guard self.questions.count > 0  else {
            throw Error.missingQuestions
            
        }
        let questions = try self.questions.map{try $0.build()}
        return QuestionGroup(questions: questions, title: title)
    }
    
    public enum Error: String, Swift.Error{
        case missingTitle
        case missingQuestions
    }
}
