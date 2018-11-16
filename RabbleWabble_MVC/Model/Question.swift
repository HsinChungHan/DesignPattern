//
//  Question.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
public class Question: Codable{
    public let answer: String
    public let hint: String?
    public let prompt: String
    
    public init(answer: String, hint: String?, prompt: String){
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
    }
}
