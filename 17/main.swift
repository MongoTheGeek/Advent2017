//
//  main.swift
//  17
//
//  Created by Mark Lively on 12/17/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

print("Hello, World!")

let testInput = 3
let input = 355

var output = [0]
var pos = 0
for i in 1...5{
    pos += testInput
    pos = pos%output.count
    output.insert(i, at: pos+1)
    pos += 1
}

print(output)

output = [0]
pos = 0
for i in 1...2017{
    pos += input
    pos = pos%output.count
    output.insert(i, at: pos+1)
    pos += 1
    if pos == 1 {print(output[0...1])}
}
print(output[pos-1],output[pos],output[pos+1])
//print(output)

//Brute force too slow

//output = [0]
//pos = 0
//for i in 1...50000000{
//    pos += input
//    pos = pos%output.count
//    output.insert(i, at: pos+1)
//    pos += 1
//    if pos == 1 {print(output[0...1])}
//}
//print(output[0...1])

//Still brute forceish but better
pos = 0
var last = 0
for i in 1...50000000{
    pos = (pos + input)%i+1
    if pos == 1 {
        last = i
        print(i)
    }
}
