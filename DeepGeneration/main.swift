//
//  main.swift
//  DeepGeneration
//
//  Created by Alicia Cicon on 3/28/15.
//  Copyright (c) 2015 Alicia Cicon. All rights reserved.
//

import Foundation

println("Hello, World!")

let fileio = FileStringIO(root:"\(NSHomeDirectory())/Desktop/DeepGeneration/Data/")

//let shapeData = Dataset<Bool,String>(features:100, outputs:1)
//
//for _ in 0..<500
//{
//    shapeData.addInstance(randomSquare().toVector(), outputVector:["square"])
//    shapeData.addInstance(randomCircle().toVector(), outputVector:["circle"])
//}
//
//let shapeDataString = datasetToString(shapeData)
//fileio.writeStringToFile("shape", ext:"arff", contents:shapeDataString)

let shapeDataString = fileio.stringFromFile("shape", ext:"arff")

println("derp")