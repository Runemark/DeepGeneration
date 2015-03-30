//
//  Dataset.swift
//  Deep-Learning
//
//  Created by Martin Mumford on 3/12/15.
//  Copyright (c) 2015 Runemark Studios. All rights reserved.
//

import Foundation

class Dataset<T,R>
{
    var inputs = [[T]]()
    var outputs = [[R]]()
    var instanceCount = 0
    var featureCount = 0
    var outputCount = 0
    
    convenience init(features:Int, outputs:Int)
    {
        self.init()
        self.featureCount = features
        self.outputCount = outputs
    }
    
    init()
    {
        
    }
    
    func addInstance(inputVector:[T], outputVector:[R])
    {
        inputs.append(inputVector)
        outputs.append(outputVector)
        instanceCount++
    }
    
    func getInstance(index:Int) -> (features:[T], targets:[R])
    {
        return (features:inputs[index], targets:outputs[index])
    }
}