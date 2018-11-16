//
//  QuestionGroup.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
public class QuestionGroup: Codable{
    public let questions: [Question]
    public let title: String
    
    //MARK: -Momento design patern
    
    //MARK: -Originator
    public class Score: Codable{
        
        public var correctCount: Int = 0{
            didSet{
                updateRunningPercentage()
            }
        }
        
        public var incorrectCount: Int = 0{
            didSet{
                updateRunningPercentage()
            }
        }
        
        private func updateRunningPercentage(){
            runningPercentage.value = caculateRunningPercentage()
        }
        
        public init(){}
        
        //MARK: -Observable DesignPattern
        public lazy var runningPercentage = Observable(value: caculateRunningPercentage())
        fileprivate func caculateRunningPercentage() -> Double{
            let totalCount = correctCount + incorrectCount
            guard totalCount > 0 else {
                return 0
            }
            return Double(correctCount) / Double(totalCount)
        }
        
        
        public func reset(){
            correctCount = 0
            incorrectCount = 0
        }
    }
    
//    public var score: Score
    //prevent all outside classes from setting score directly
    public private(set) var score: Score
    
    public init(questions: [Question], score: Score = Score(), title: String){
        self.questions = questions
        self.title = title
        self.score = score
    }
}


