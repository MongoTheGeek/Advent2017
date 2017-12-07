//
//  main.swift
//  6
//
//  Created by Mark Lively on 12/5/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let input = [4,    10,    4,    1,    8,    4,    9,    14,    5,    1,    14,    15,    0,    15,    3,    5]

var count = 0
var outArray = Array<String>()
var current = "\(input)"
var cArray = input

while !outArray.contains(current) {
    outArray.append(current)
    var max = cArray.max()!
    var found = false
    var i = 0
    while max > 0 {
        if !found {
            if cArray[i] == max {
                found = true
                cArray[i] = 0
            }
        } else {
            cArray[i] = cArray[i] + 1
            max -= 1
        }
        i = (i + 1) % input.count
    }
    current = "\(cArray)"
    count += 1
}

print(count, cArray)

print("\n\n\n-----\tPart 2\t-----\n\n\n")

outArray = []
count = 0


while !outArray.contains(current) {
    outArray.append(current)
    var max = cArray.max()!
    var found = false
    var i = 0
    while max > 0 {
        if !found {
            if cArray[i] == max {
                found = true
                cArray[i] = 0
            }
        } else {
            cArray[i] = cArray[i] + 1
            max -= 1
        }
        i = (i + 1) % input.count
    }
    current = "\(cArray)"
    count += 1
}

print(count, cArray)

