//
//  ARFFFactory.swift
//  DeepGeneration
//
//  Created by Martin Mumford on 3/30/15.
//  Copyright (c) 2015 Alicia Cicon. All rights reserved.
//

import Foundation

func datasetToString(dataset:Dataset<Bool,String>) -> String
{
    var arffString = "@RELATION circlevssquare"
    
    for attributeIndex in 0..<dataset.featureCount
    {
        arffString += "@ATTRIBUTE pixel\(attributeIndex) real\n"
    }
    
    arffString += "@ATTRIBUTE class {circle, square}\n\n"
    arffString += "@DATA\n"
    
    for instanceIndex in 0..<dataset.instanceCount
    {
        let instance = dataset.getInstance(instanceIndex)
        var instanceString = ""
        for featureIndex in 0..<instance.features.count
        {
            let value = instance.features[featureIndex]
            if (value)
            {
                instanceString += "1,"
            }
            else
            {
                instanceString += "0,"
            }
        }
        
        // WARXING: ASSUMES ONLY 1 TARGET PER INSTANCE
        instanceString += "\(instance.targets[0])\n"
        arffString += instanceString
    }
    
    return arffString
}

func datasetFromString(dataString:String)
{
    var dataset = Dataset<Bool,String>()
    
    var featureCount = 0
    
    // WARXING: ASSUMES ONLY 1 TARGET PER INSTANCE
    var outputCount = 1
    
    var dataSection = false
    
    for line in dataString.componentsSeparatedByString("\n")
    {
        if line.rangeOfString("@ATTRIBUTE") != nil
        {
            if line.rangeOfString("class") != nil
            {
                // deal with class string
                // we can actually ignore this for now
            }
            else
            {
                featureCount++
            }
        }
        else if line.rangeOfString("@DATA")
        {
            // Data Section Begun
            dataSection = true
        }
        else if (dataSection)
        {
            // This is an instance
            var features = [Bool]()
            
            let components = line.componentsSeparatedByString(",")
            for componentIndex in 0..<components.count-1
            {
                let value = components[0].toInt()!
                if (value == 0)
                {
                    features.append(false)
                }
                else
                {
                    features.append(true)
                }
            }
            
            let classification = components[components.count-1]
            
            
            dataset.addInstance(features, outputVector:[classification])
        }
    }
}

func imageToDataInstance(image:Array2D<Bool>, classification:String) -> String
{
    var dataInstanceString = ""
    
    for x in 0..<image.rows
    {
        for y in 0..<image.cols
        {
            dataInstanceString += "\(image[x,y]),"
        }
    }
    
    dataInstanceString += "\(classification)"
    
    return dataInstanceString
}