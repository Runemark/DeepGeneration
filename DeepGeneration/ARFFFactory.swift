//
//  ARFFFactory.swift
//  DeepGeneration
//
//  Created by Martin Mumford on 3/30/15.
//  Copyright (c) 2015 Alicia Cicon. All rights reserved.
//

import Foundation

func datasetToString(dataset:Dataset<Float,Float>) -> String
{
    var arffString = "@RELATION circlevssquare"
    
    for attributeIndex in 0..<dataset.featureCount
    {
        arffString += "@ATTRIBUTE p\(attributeIndex) real\n"
    }
    
    arffString += "@ATTRIBUTE class real (square = 0.0ish, circle = 1.0ish)\n\n"
    arffString += "@DATA\n"
    
    for instanceIndex in 0..<dataset.instanceCount
    {
        let instance = dataset.getInstance(instanceIndex)
        var instanceString = ""
        for featureIndex in 0..<instance.features.count
        {
            let value = instance.features[featureIndex]
            instanceString += "\(value),"
        }
        
        // WARXING: ASSUMES ONLY 1 TARGET PER INSTANCE
        instanceString += "\(instance.targets[0])\n"
        arffString += instanceString
    }
    
    return arffString
}

func transformDataSet(dataset:Dataset<Float,Float>, network:TransformLayer) -> Dataset<Float,Float>
{
    return Dataset<Float,Float>()
}

func autoencodeDataset(dataset:Dataset<Float,Float>, denoise:Bool, denoisePercent:Float) -> Dataset<Float,Float>
{
    let autoencodedDataset = Dataset<Float,Float>()
    
    for instanceIndex in 0..<dataset.instanceCount
    {
        let instance = dataset.getInstance(instanceIndex)
        let features = instance.features
        var newFeatures = [Float]()
        
        if (denoise)
        {
            for featureIndex in 0..<features.count
            {
                let feature = features[featureIndex]
                if (randNormalFloat() > denoisePercent)
                {
                    newFeatures.append(Float(0.0))
                }
                else
                {
                    newFeatures.append(feature)
                }
            }
        }
        
        if (denoise)
        {
            autoencodedDataset.addInstance(newFeatures, outputVector:instance.features)
        }
        else
        {
            autoencodedDataset.addInstance(instance.features, outputVector:instance.features)
        }
    }
    
    return autoencodedDataset
}

func datasetFromString(dataString:String) -> Dataset<Float,Float>
{
    var dataset = Dataset<Float,Float>()
    
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
        else if line.rangeOfString("@DATA") != nil
        {
            // Data Section Begun
            dataSection = true
        }
        else if (dataSection && countElements(line) > 0)
        {
            // This is an instance
            var features = [Float]()
            
            let components = line.componentsSeparatedByString(",")
            for componentIndex in 0..<components.count-1
            {
                let value = components[componentIndex].floatValue
                features.append(value)
            }
            
            let classification = components[components.count-1].floatValue
            dataset.addInstance(features, outputVector:[classification])
        }
    }
    
    return dataset
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