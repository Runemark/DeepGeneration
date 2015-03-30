//
//  SquareFactory.swift
//  DeepGeneration
//
//  Created by Alicia Cicon on 3/28/15.
//  Copyright (c) 2015 Alicia Cicon. All rights reserved.
//

import Foundation

struct coord
{
    var x:Int
    var y:Int
}

func rectWithCorners(nw:coord, sw:coord, se:coord, ne:coord) -> Array2D<Bool>
{
    var squareImage = Array2D<Bool>()
    
    for x in nw.coord.x...sw.coord.x
    {
        
    }
    
    return squareImage
}

func rectWithCenter(center:coord, width:Int, height:Int)
{
    
}