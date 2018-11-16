//
//  SequesntialQuestionStrategy.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation

public class SequentialQuestionStrategy: BaseQuestionStrategy{
    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let questions = questionGroup.questions
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
    
}
