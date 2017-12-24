//
//  main.swift
//  19
//
//  Created by Mark Lively on 12/19/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

func navigate(_ input:String) -> String {
    enum Direction {
        case up, down, left, right
    }

    let grid = input.split(separator: "\n").map{String($0).map{String($0)}}
    let ymax = grid.count
    let xmax = grid[0].count
    var x = 0
    var y = 0
    var output = ""
    //Find start
//    print (grid)
    while grid[0][x] != "|"{
        x += 1
    }
    
    var dir = Direction.down
    while x<xmax && x>=0 && y<ymax && y>=0 {
         var cont = true
        switch grid[y][x]{
        case " ":
            print(x,y)
            return output
        case "|","-":
            cont = true
        case "+":
            cont = false
        default:
            cont = true
            output.append(grid[y][x])
        }
        if cont {
            switch dir {
            case .up:
                y -= 1
            case .down:
                y += 1
            case .left:
                x -= 1
            case .right:
                x += 1
            }
        } else {
            switch dir {
            case .up,.down:
                if x < xmax - 1  && grid[y][x+1] != " "{
                    x += 1
                    dir = .right
                } else {
                    x -= 1
                    dir = .left
                }
            case .right,.left:
                if y < ymax - 1  && grid[y+1][x] != " " {
                    y += 1
                    dir = .down
                } else {
                    y -= 1
                    dir = .up
                }
            }
        }
    }
    
    return output
}
print(navigate(test))

print(navigate(input))

print("\n\n\n-----\tPart 2\t-----\n\n\n")

func navigateWithSteps(_ input:String) -> (String,Int) {
    enum Direction {
        case up, down, left, right
    }
    
    let grid = input.split(separator: "\n").map{String($0).map{String($0)}}
    let ymax = grid.count
    let xmax = grid[0].count
    var x = 0
    var y = 0
    var steps = 0
    var output = ""
    //Find start
    //    print (grid)
    while grid[0][x] != "|"{
        x += 1
    }
    
    var dir = Direction.down
    while x<xmax && x>=0 && y<ymax && y>=0 {
        var cont = true
        switch grid[y][x]{
        case " ":
            print(x,y)
            return (output,steps)
        case "|","-":
            cont = true
        case "+":
            cont = false
        default:
            cont = true
            output.append(grid[y][x])
        }
        if cont {
            switch dir {
            case .up:
                y -= 1
            case .down:
                y += 1
            case .left:
                x -= 1
            case .right:
                x += 1
            }
        } else {
            switch dir {
            case .up,.down:
                if x < xmax - 1  && grid[y][x+1] != " "{
                    x += 1
                    dir = .right
                } else {
                    x -= 1
                    dir = .left
                }
            case .right,.left:
                if y < ymax - 1  && grid[y+1][x] != " " {
                    y += 1
                    dir = .down
                } else {
                    y -= 1
                    dir = .up
                }
            }
        }
        steps += 1
    }
    
    return (output,steps)
}
print(navigateWithSteps(test))

print(navigateWithSteps(input))


