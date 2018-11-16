//
//  QuestionBuilder.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
public class QuestionBuilder{
    public var answer = ""
    public var hint = ""
    public var prompt = ""
    
    public func build() throws -> Question{
        guard answer.count > 0 else {
            throw Error.missingAnswer}
        guard prompt.count > 0 else {
            throw Error.missingPrompt}
        return Question(answer: answer, hint: hint, prompt: prompt)
    }
    
    public enum Error: String, Swift.Error{
        case missingAnswer
        case missingPrompt
    }
}
