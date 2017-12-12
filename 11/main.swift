//
//  main.swift
//  11
//
//  Created by Mark Lively on 12/11/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

var x = 0
var y = 0
var max = 0
func dist(_ x:Int, _ y:Int) -> Int {
    let ax = abs(x)
    let steps = ax + (abs(abs(y)-ax)) / 2
    return steps
}

for s in input.split(separator:","){
    switch s {
    case "n":
        y += 2
    case "s":
        y -= 2
    case "se":
        x += 1
        y -= 1
    case "ne":
        x += 1
        y += 1
    case "sw":
        x -= 1
        y -= 1
    case "nw":
        x -= 1
        y += 1
    default:
        assert(false, String(s))
    }
    if dist(x,y) > max {max = dist(x,y)}
}
let ax = abs(x)
let steps = ax + (abs(abs(y)-ax)) / 2
print(input.split(separator:",").count,steps,max,x,y)


print("\n\n\n-----\tPart 2\t-----\n\n\n")

