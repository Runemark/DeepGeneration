//
//  Stopwatch.swift
//  DeepGeneration
//
//  Created by Alicia Cicon on 3/28/15.
//  Copyright (c) 2015 Alicia Cicon. All rights reserved.
//

import Foundation

class Stopwatch
{
    var startTime:CFAbsoluteTime
    
    init()
    {
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func start()
    {
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func stop() -> CFAbsoluteTime
    {
        return CFAbsoluteTimeGetCurrent() - startTime
    }
}