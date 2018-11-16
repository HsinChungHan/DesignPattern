//
//  RandomQuestionStrategy.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: BaseQuestionStrategy{
    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker){
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
