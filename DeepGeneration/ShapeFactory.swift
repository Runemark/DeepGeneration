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

func imageToFloatGrid(image:Array2D<Bool>) -> Array2D<Float>
{
    var floatGrid = Array2D<Float>(rows:10, cols:10, filler:Float(0.0))
    
    for x in 0..<10
    {
        for y in 0..<10
        {
            if (image[x,y])
            {
                floatGrid[x,y] = Float(1.0)
            }
        }
    }
    
    return floatGrid
}

func circleWithCenter(c:coord, r:Int) -> Array2D<Bool>
{
    var circleImage = Array2D<Bool>(rows:10, cols:10, filler:false)
    
    if (r == 1)
    {
        circleImage[c.x-1,c.y] = true
        circleImage[c.x,c.y-1] = true
        circleImage[c.x+1,c.y] = true
        circleImage[c.x,c.y+1] = true
    }
    else if (r == 2)
    {
        circleImage[c.x-2,c.y+1] = true
        circleImage[c.x-2,c.y+0] = true
        circleImage[c.x-2,c.y-1] = true
        circleImage[c.x-1,c.y-2] = true
        circleImage[c.x+0,c.y-2] = true
        circleImage[c.x+1,c.y-2] = true
        circleImage[c.x+2,c.y-1] = true
        circleImage[c.x+2,c.y+0] = true
        circleImage[c.x+2,c.y+1] = true
        circleImage[c.x+1,c.y+2] = true
        circleImage[c.x+0,c.y+2] = true
        circleImage[c.x-1,c.y+2] = true
    }
    else if (r == 3)
    {
        circleImage[c.x-3,c.y+1] = true
        circleImage[c.x-3,c.y+0] = true
        circleImage[c.x-3,c.y-1] = true
        circleImage[c.x-2,c.y-2] = true
        circleImage[c.x-1,c.y-3] = true
        circleImage[c.x+0,c.y-3] = true
        circleImage[c.x+1,c.y-3] = true
        circleImage[c.x+2,c.y-2] = true
        circleImage[c.x+3,c.y-1] = true
        circleImage[c.x+3,c.y+0] = true
        circleImage[c.x+3,c.y+1] = true
        circleImage[c.x+2,c.y+2] = true
        circleImage[c.x+1,c.y+3] = true
        circleImage[c.x+0,c.y+3] = true
        circleImage[c.x-1,c.y+3] = true
        circleImage[c.x-2,c.y+2] = true
    }
    
    return circleImage
}

func randomCircle() -> Array2D<Bool>
{
    // Select a random valid center (WARXING: assuming a 10x10 space, must fall betweeen 1 and 8 inclusive in both x and y direction)
    let randX = randIntBetween(3, 6)
    let randY = randIntBetween(3, 6)
    let randCenter = coord(x:randX, y:randY)
    
    // Based on the centerpoint, generate the random radius
    let minDist = minDistanceToEdge(randCenter)
    let randRadius = randIntBetween(1, minDist)

    return circleWithCenter(randCenter, min(randRadius,3)) // Currently only supports circles of max radius 3
}

func rectWithCorners(nw:coord, sw:coord, se:coord, ne:coord) -> Array2D<Bool>
{
    // WARXING HARDCODED TO BE A 10X10 IMAGE
    var squareImage = Array2D<Bool>(rows:10, cols:10, filler:false)
    
    // Left Side
    for x in nw.x...sw.x
    {
        squareImage[x,nw.y] = true
    }
    
    // Down Side
    for y in sw.y...se.y
    {
        squareImage[sw.x,y] = true
    }
    
    // Right Side
    for x in ne.x...se.x
    {
        squareImage[x,ne.y] = true
    }
    
    // Top Side
    for y in nw.y...ne.y
    {
        squareImage[nw.x,y] = true
    }
    
    return squareImage
}

func rectWithCenter(c:coord, h:Int, w:Int) -> Array2D<Bool>
{
    return rectWithCorners(coord(x:c.x-h, y:c.y-w), coord(x:c.x+h, y:c.y-w), coord(x:c.x+h, y:c.y+w), coord(x:c.x-h, y:c.y+w))
}

func minDistanceToEdge(point:coord) -> Int
{
    // WARXING: ASSUMING A 10x10 SPACE
    let distToLeftEdge = point.y
    let distToDownEdge = 10 - point.x
    let distToRightEdge = 10 - point.y
    let distToUpEdge = point.x
    
    let minDist:Int = min(distToLeftEdge, distToDownEdge, distToRightEdge, distToUpEdge)
    return minDist
}

func squareWithCenter(c:coord, r:Int) -> Array2D<Bool>
{
    return rectWithCenter(c, r, r)
}

// Generates a random square with minimum radius of 1
func randomSquare() -> Array2D<Bool>
{
    // Select a random valid center (WARXING: assuming a 10x10 space, must fall betweeen 1 and 8 inclusive in both x and y direction)
    let randX = randIntBetween(3, 6)
    let randY = randIntBetween(3, 6)
    let randCenter = coord(x:randX, y:randY)
    
    // Based on the centerpoint, generate the random radius
    var minDist = minDistanceToEdge(randCenter)
    if (minDist > 1)
    {
        minDist = minDist - 1
    }
    let randRadius = randIntBetween(1, minDist)
    
    return squareWithCenter(randCenter, randRadius)
}

func imageToString(image:Array2D<Bool>) -> String
{
    var imageString = ""
    
    let imageHeight = image.rows
    let imageWidth = image.cols
    
    for x in 0..<imageHeight
    {
        for y in 0..<imageWidth
        {
            if (image[x,y])
            {
                imageString += "X"
            }
            else
            {
                imageString += "."
            }
            
            if (y < imageWidth-1)
            {
                imageString += ","
            }
        }
        imageString += "\n"
    }
    
    return imageString
}