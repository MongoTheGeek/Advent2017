//
//  main.swift
//  10
//
//  Created by Mark Lively on 12/10/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

//let input = "3,4,1,5"
var hash = Array<Int>()
let max = 256

for i in 0...max-1{
    hash.append(i)
}
var skip = 0
var position = 0
for length in input.split(separator:","){
    let l = Int(length)!
    if l <= max {
        if position + l > max {
            let temp1 = hash.prefix(position + l - max)
            let temp2 = hash.suffix(max - position)
            let temp3 = Array(hash.dropFirst(position + l - max).dropLast(max-position))
            let temp4 = Array((temp2 + temp1).reversed())
            hash = Array(temp4.dropFirst(max - position)) + temp3 + Array(temp4.prefix(max - position))
        } else {
            let temp1 = hash.prefix(position)
            let temp2 = Array(hash.dropFirst(position).prefix(l).reversed())
            let temp3 = hash.suffix(max-position-l)
            hash = temp1 + temp2 + temp3
        }
        position = (position + l + skip) % max
        skip += 1
    }
}

print(hash[0]*hash[1])

print("\n\n\n-----\tPart 2\t-----\n\n\n")

var input2 = Array<Int>()

let test1 = ""
let test2 =  "AoC 2017"
let test3 = "1,2,3"
let test4 = "1,2,4"

for c in input{
    input2.append(Int(String(c).cString(using: .ascii)![0]))
}

input2.append(contentsOf: [17, 31, 73, 47, 23])
print(input2)

hash = Array<Int>()
for i in 0...max-1{
    hash.append(i)
}
skip = 0
position = 0
for _ in 1...64 {
    for l in input2{
        if l <= max {
            if position + l > max {
                let temp1 = hash.prefix(position + l - max)
                let temp2 = hash.suffix(max - position)
                let temp3 = Array(hash.dropFirst(position + l - max).dropLast(max-position))
                let temp4 = Array((temp2 + temp1).reversed())
                hash = Array(temp4.dropFirst(max - position)) + temp3 + Array(temp4.prefix(max - position))
            } else {
                let temp1 = hash.prefix(position)
                let temp2 = Array(hash.dropFirst(position).prefix(l).reversed())
                let temp3 = hash.suffix(max-position-l)
                hash = temp1 + temp2 + temp3
            }
            position = (position + l + skip) % max
            skip += 1
        }
    }
}
var output = ""
for i in 0...15 {
    let sub = hash[(i*16)...(i*16+15)]
    let reduced = sub.reduce(0, ^)
    output.append(String(format:"%02x", reduced))  //leading 0s  thank you Reddit
}
print(output,output.lengthOfBytes(using: .ascii))
