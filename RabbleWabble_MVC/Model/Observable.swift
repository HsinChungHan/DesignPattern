//
//  Observable.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/7.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
public class Observable<T>{
    //MARK: -Callback
    fileprivate class Callback{
        fileprivate weak var observer: AnyObject?
        fileprivate let options: [ObservableOptions]
        fileprivate let closure: (T, ObservableOptions) -> Void
        
        fileprivate init(observer: AnyObject, options: [ObservableOptions], closure: @escaping (T, ObservableOptions) -> Void){
            self.observer = observer
            self.options = options
            self.closure = closure
        }
    }
    
    //MARK: -Properties
    public var value: T
    
    //MARK: -Object Lifecycle
    public init(value: T){
        self.value = value
    }
    
    //MARK: Manager Observers
    private var callbacks: [Callback] = []
    
    public func addObserver(_ observer: AnyObject, removeIfExist: Bool = true, options: [ObservableOptions] = [ObservableOptions.new], closure: @escaping (T, ObservableOptions) -> Void){
        if removeIfExist{
            removeObserver(observer)
        }
        
        let callback = Callback(observer: observer, options: options, closure: closure)
        callbacks.append(callback)
        
        if options.contains(.initial){
            closure(value, .initial)
        }
    }
    
    public func removeObserver(_ observer: AnyObject){
        //不一樣的留下來，換句話說殺掉傳進來的observer
        //!== 代表不是同個物件
        callbacks = callbacks.filter{$0.observer !== observer}
    }
}

//MARK: -ObservableOptions
public struct ObservableOptions: OptionSet{
    //就是說三種不同的states
    //moves 0 bits to left for 00000001
    public static let initial = ObservableOptions(rawValue: 1 << 0)//1
    // moves 1 bits to left for 00000001 then you have 00000010
    public static let old = ObservableOptions(rawValue: 1 << 1)//2
    // moves 2 bits to left for 00000001 then you have 00000100
    public static let new = ObservableOptions(rawValue: 1 << 2)//4
    
    public var rawValue: Int
    
    public init(rawValue: Int){
        self.rawValue = rawValue
    }
    
}


//
//Example using code
//

//public class User{
//    public let name: Observable<String>
//    public init(name: String){
//        self.name = Observable(value: name)
//    }
//}
//
//public class Observer{}
//
//public class TestVC: UIViewController{
//    let user = User(name: "HsinHan")
//    var observer: Observer? = Observer()
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//        user.name.addObserver(observer!, removeIfExist: true, options: [.initial, .new]) { (name, change) in
//            print("User name is \(name), change is \(change)")
//        }
//    }
//
//}
