//
//  main.swift
//  14
//
//  Created by Mark Lively on 12/14/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let input = "wenycdww"

func hashToGrid(_ input:String)->String {
    var output = ""
    for c in input{
        switch c {
        case "0":
            output.append("....")
        case "1":
            output.append("...#")
        case "2":
            output.append("..#.")
        case "3":
            output.append("..##")
        case "4":
            output.append(".#..")
        case "5":
            output.append(".#.#")
        case "6":
            output.append(".##.")
        case "7":
            output.append(".###")
        case "8":
            output.append("#...")
        case "9":
            output.append("#..#")
        case "a":
            output.append("#.#.")
        case "b":
            output.append("#.##")
        case "c":
            output.append("##..")
        case "d":
            output.append("##.#")
        case "e":
            output.append("###.")
        case "f":
            output.append("####")
        default:
            assert(false)
        }
    }
    return output
}


func countGrid(_ input:String)->Int {
    var output = 0
    for c in input{
        switch c {
        case "0":
            output += 0
        case "1", "2", "4", "8":
            output += 1
        case "3", "5", "9", "6", "a", "c":
            output += 2
        case "e", "d", "b", "7":
            output += 3
        case "f":
            output += 4
        default:
            assert(false)
        }
    }
    return output
}

let test = "flqrgnkx"
var output = 0
for i in 0...127 {
    output += countGrid(knotHash("\(input)-\(i)"))
    //    print(hashToGrid(knotHash("\(test)-\(i)")))
}
print(output)

print("\n\n\n-----\tPart 2\t-----\n\n\n")

var data = ""
for i in 0...127 {
    data.append(hashToGrid(knotHash("\(input)-\(i)")))
}

var matched = Set<Int>()
var sets = 0
for i in 0...data.lengthOfBytes(using: .ascii) {
    if !matched.contains(i) && data[i]=="#"{
        sets += 1
        var set = [i]
        matched.insert(i)
        var j = 0
        while j < set.count{
            let k = set[j]
            if (k > 127 && !matched.contains(k-128) && data[k-128] == "#"){
                matched.insert(k-128)
                set.append(k-128)
            }
            if (k < 127 * 128 && !matched.contains(k+128) && data[k+128] == "#"){
                matched.insert(k+128)
                set.append(k+128)
            }
            if (k % 128 < 127 && !matched.contains(k+1) && data[k+1] == "#"){
                matched.insert(k+1)
                set.append(k+1)
            }
            if (k % 128 > 0 * 128 && !matched.contains(k-1) && data[k-1] == "#"){
                matched.insert(k-1)
                set.append(k-1)
            }
            j += 1
        }
    }
}

print(sets,matched.count)
