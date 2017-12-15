//
//  main.swift
//  13
//
//  Created by Mark Lively on 12/13/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let testInput = """
0: 3
1: 2
4: 4
6: 4
"""

var firewall = Array<Int>()
for _ in 0...99{firewall.append(0)}
for l in input.split(separator:"\n"){
    let t = l.split(separator:":")
    firewall[Int(t[0])!] = Int(String(t[1]).dropFirst())!
}

func calcScore(offset:Int) -> (Int,Bool){
    var output = 0
    var caught = false
    for i in 0...firewall.count - 1{
        if firewall[i] != 0 {
            if (i + offset) % (2 * firewall[i] - 2) == 0 {
                output += i*firewall[i]
                caught = true
//                print (output, i, firewall[i])
            }
        }
    }
    return (output,caught)
}

print(calcScore(offset: 0))


print("\n\n\n-----\tPart 2\t-----\n\n\n")

var s = Set<Int>()
for i in firewall{
    s.insert(i)
}

var max = 1
for i in s {
    if i != 0 {max *= (2*i - 2)}
}

for i in 1...max {
    let (score, caught) = calcScore(offset: i)
    if !caught {
        print(i)
        break
    }
}
print(calcScore(offset: 146664))
