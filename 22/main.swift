//
//  main.swift
//  22
//
//  Created by Mark Lively on 12/22/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let test = """
..#
#..
...
"""

func expand(_ input:Array<Array<String>>)->Array<Array<String>>{
    let c = input.count
    var newline = ["."]
    for _ in 0...c+2{ newline.append(".")}
    var output = [newline,newline]
    for l in input{
        let t = [".","."]+l+[".","."]
        output.append(t)
    }
    output.append(newline)
    output.append(newline)
    return output
}

enum Dir:Int {
    case up, left, down, right
    func turnLeft()->Dir {
        return Dir(rawValue:(self.rawValue + 1) % 4)!
    }
    func turnRight()->Dir {
        return Dir(rawValue:(self.rawValue + 3) % 4)!
    }
    func turnAround()->Dir {
        return Dir(rawValue:(self.rawValue + 2) % 4)!
    }
}

let testGrid = test.split(separator: "\n").map{String($0).map{String($0)}}
let inputGrid = input.split(separator: "\n").map{String($0).map{String($0)}}

var grid = Array<Array<String>>()
var x = 1
var y = 1
var dir = Dir.up

var turnOn = 0
var turnOff = 0


func move(){
    if grid[y][x] == "#" {
        turnOff += 1
        dir = dir.turnRight()
        grid[y][x] = "."
    } else {
        turnOn += 1
        dir = dir.turnLeft()
        grid[y][x] = "#"
    }
    switch dir {
    case .up:
        y-=1
    case .left:
        x-=1
    case .down:
        y+=1
    case .right:
        x+=1
    }
    if x==0 || y==0 || x == grid.count-1 || y == grid.count-1{
        x += 2
        y += 2
        grid = expand(grid)
    }
}

grid = testGrid
for _ in 0...69{move()}
print(dir,turnOn)
print(grid.map({[$0.joined()]}).flatMap({$0}).joined(separator:"\n"))
for _ in 0...9929{move()}
print(dir,turnOn)


print("\nActual\n")
dir = .up
turnOn=0
turnOff=0
grid=inputGrid
x=grid[0].count/2
y=grid.count/2
for _ in 1...10000{move()}
print(dir,turnOn)
//print(inputGrid.flatMap({$0}).reduce(0, {$0 + ($1 == "#" ? 1 : 0)}))
//print(grid.flatMap({$0}).reduce(0, {$0 + ($1 == "#" ? 1 : 0)}))



print("\n\n\n-----\tPart 2\t-----\n\n\n")


func move2(){
    if grid[y][x] == "#" {
        dir = dir.turnRight()
        grid[y][x] = "F"
    } else if grid[y][x] == "F" {
        turnOff += 1
        dir = dir.turnAround()
        grid[y][x] = "."
    } else if grid[y][x] == "W" {
        turnOn += 1
        grid[y][x] = "#"
    } else if grid[y][x] == "." {
        dir = dir.turnLeft()
        grid[y][x] = "W"
    } else {
        assert(false)
    }
    switch dir {
    case .up:
        y-=1
    case .left:
        x-=1
    case .down:
        y+=1
    case .right:
        x+=1
    }
    if x==0 || y==0 || x == grid.count-1 || y == grid.count-1{
        x += 2
        y += 2
        grid = expand(grid)
    }
}


grid = testGrid
dir = .up
turnOn=0
turnOff=0
x=grid[0].count/2
y=grid.count/2


for _ in 0...99{move2()}
print(dir,turnOn)
print(grid.map({[$0.joined()]}).flatMap({$0}).joined(separator:"\n"))
for _ in 0...9999899{move2()}
print(dir,turnOn)

print("\nActual\n")


grid = inputGrid
dir = .up
turnOn=0
turnOff=0
x=grid[0].count/2
y=grid.count/2

for _ in 0...9999999{move2()}
print(dir,turnOn)

