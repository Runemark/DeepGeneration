//
//  FileStringIO.swift
//  DeepGeneration
//
//  Created by Martin Mumford on 3/30/15.
//  Copyright (c) 2015 Alicia Cicon. All rights reserved.
//

import Foundation

class FileStringIO
{
    var root:String
    
    init(root:String)
    {
        self.root = root
    }
    
    func stringFromFile(fileName:String, ext:String) -> String?
    {
        let directory = "\(root)\(fileName).\(ext)"
        var loadedData:String
        do{
            try loadedData =  String(contentsOfFile:directory, encoding:NSUTF8StringEncoding)
        }
        catch let error as NSError {
            print(error.localizedDescription)
            
            return nil
        }
        
        return loadedData
        
        
    }
    
    func writeStringToFile(fileName:String, ext:String, contents:String)
    {
        let directory = "\(root)\(fileName).\(ext)"
        
        do {
            try contents.writeToFile(directory, atomically:false, encoding:NSUTF8StringEncoding)
        } catch _ {
        }
    }
}