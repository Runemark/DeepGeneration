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
    }
    
    return arffString
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

//func exportArffFile(dataset:Dataset) -> String
//{
//    var exportString = "@RELATION DATA=train-images.idx3-ubyte-LABELS=train-labels.idx1-ubyte\n\n"
//    
//    for attributeIndex in 1...dataset.getInstance(0).features.count
//    {
//        exportString += "@ATTRIBUTE f\(attributeIndex)  real\n"
//    }
//    
//    exportString += "@ATTRIBUTE class {0,1,2,3,4,5,6,7,8,9}\n\n"
//    exportString += "@DATA\n"
//    
//    for instanceIndex in 0..<dataset.instanceCount
//    {
//        let instance = dataset.getInstance(instanceIndex)
//        var instanceString = ""
//        for featureIndex in 0..<instance.features.count
//        {
//            let normalizedFeature = instance.features[featureIndex]
//            let unnormalizedFeature = Int(floor(normalizedFeature*255))
//            instanceString += "\(unnormalizedFeature),"
//        }
//        
//        let outputClass = Int(dataset.outputs[instanceIndex][0])
//        
//        instanceString += "\(outputClass)\n"
//        exportString += instanceString
//    }
//    
//    return exportString
//}
