//
//  AppSetting.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/1.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
public class AppSetting{
    
    //MARK: -Static Properties
    public static let shared = AppSetting()
    
    //For Userdefault
    //----------------
    //MARK: -Keys
    private struct Keys{
        static let questionStrategy = "questionStrategy"
    }
    
    //MARK: - Instance Properties
    private let userDefault = UserDefaults.standard
    public var questionStrategyType: QuestionStrategyType{
        get{
            let rawValue = userDefault.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        }set{
            userDefault.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    //----------------
    
    //MARK: -Object LifeCycle
    private init(){}
    
    //MARK: -Instances Method
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy{
        return questionStrategyType.questionStrategy(for: questionGroupCaretaker)
    }
}


public enum QuestionStrategyType: Int, CaseIterable{
    case random
    case sequential
    
    //MARK: -Insyance Methods
    public func title() -> String{
        switch self {
        case .random:
            return "Random"
        case .sequential:
            return "Sequential"
        }
    }
    
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy{
        switch self {
        case .random:
            return RandomQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        case .sequential:
            return SequentialQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        }
    }
}
