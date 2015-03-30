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
        
        if let loadedData = String(contentsOfFile:directory, encoding:NSUTF8StringEncoding, error:nil)
        {
            return loadedData
        }
        else
        {
            return nil
        }
    }
    
    func writeStringToFile(fileName:String, ext:String, contents:String)
    {
        let directory = "\(root)\(fileName).\(ext)"
        
        contents.writeToFile(directory, atomically:false, encoding:NSUTF8StringEncoding, error:nil)
    }
}