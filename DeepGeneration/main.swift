//
//  main.swift
//  DeepGeneration
//
//  Created by Alicia Cicon on 3/28/15.
//  Copyright (c) 2015 Alicia Cicon. All rights reserved.
//

import Foundation

println("Hello, World!")

let shapeData = Dataset<Bool,String>(features:100, outputs:1))

for _ in 0..<500
{
    shapeData.addInstance(randomSquare().toVector(), outputVector:["square"])
    shapeData.addInstance(randomCircle().toVector(), outputVector:["circle"])
}

