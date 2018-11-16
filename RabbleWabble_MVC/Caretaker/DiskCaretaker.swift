//
//  DiskCareTaker.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/11/2.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
public class DiskCaretaker{
    public static let decoder = JSONDecoder()
    public static let encoder = JSONEncoder()
    
    public static func creatDocumentURL(withFileName fileName: String) -> URL?{
        let fileManager = FileManager.default
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return url.appendingPathComponent(fileName).appendingPathExtension("json")
    }
    
    //MARK: -Save
    public static func save<T: Codable>(_ object: T, to fileName: String) throws{
        do{
            guard let url = creatDocumentURL(withFileName: fileName) else {return}
            let data = try encoder.encode(object)
            try data.write(to: url, options: .atomic)
        }catch (let error){
            print("Failed to save object `\(object)` " + "Error: `\(error)`")
            throw error
        }
    }
    
    //MARK: -Retrive
    public static func retrive<T: Codable>(_ type: T.Type, from url: URL) throws -> T{
        do{
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        }catch (let error){
            print("Failed to retrive: URL `\(url)`" + "Error: `\(error)`")
            throw error
        }
    }
    
    public static func retrive<T: Codable>(_ type: T.Type, from fileName: String) throws -> T?{
        do{
            guard let url = creatDocumentURL(withFileName: fileName) else {return nil}
            return try retrive(T.self, from: url)
        }catch let error{
            print("Failed to retrive: fileName `\(fileName)`" + "Error: `\(error)`")
            throw error
        }
    }
}
