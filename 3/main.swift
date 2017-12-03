//
//  main.swift
//  3
//
//  Created by Mark Lively on 12/3/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let input = 265149

func position(_ input: Int) -> (Int, Int) {
    var x = 0
    var y = 0
    var l = 0
    var side = 4
    if input <= 1 {return (0,0)}
    for _ in 2 ... input{
        if side == 1 && y == l {
            side = 2
        } else if side == 2 && x == -l {
            side = 3
        } else if side == 3 && y == -l {
            side = 4
        } else if side == 4 && x > l {
            side = 1
            l += 1
        }
        switch side {
        case 1:
            y += 1
        case 2:
            x -= 1
        case 3:
            y -= 1
        case 4:
            x += 1
        default:
            print("oops")
        }
    }
    return (x,y)
}

func distance(_ input: Int) -> Int {
//    print(input, x, y)
    let (x,y) = position(input)
    return abs(x) + abs(y)
}

print(distance (1))
print(distance (2))
print(distance (3))
print(distance (4))
print(distance (5))
print(distance (12))
print(distance (23))
print(distance (1024))
print(distance (input))


print("\n\n\n-----\tPart 2\t-----\n\n\n")

var totArray = [1]
var posArray = [(0,0)]

func value(_ n:Int) -> Int {
    var result = 0
    let (x,y) = posArray[n]
    for i in -1 ... 1 {
        for j in -1 ... 1 {
            let x1 = x + i
            let y1 = y + j
            var k = 0
            while k < posArray.count && posArray[k] != (x1,y1) {
                k += 1
            }
            if k < totArray.count  {
                result += totArray[k]
                print(n, posArray[k])
            }
        }
    }
    return result
}


for i in 2...2000{
    posArray.append(position(i-1))
    totArray.append(value(i-1))
    print(i,posArray[i-1],totArray[i-1])
    if totArray[i-1] > input {
        print(totArray[i-1])
        break
    }
}

