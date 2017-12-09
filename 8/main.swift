//
//  main.swift
//  8
//
//  Created by Mark Lively on 12/8/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

//let input = """
//b inc 5 if a > 1
//a inc 1 if b < 5
//c dec -10 if a >= 1
//c inc -20 if c == 10
//"""

var max = -99999999
var out = ""

var registers = Dictionary<String, Int>()
for line in input.split(separator:"\n"){
    let tokens = line.split(separator:" ")
    assert(tokens[3]=="if")
    assert(tokens[1]=="inc" || tokens[1]=="dec" )
    let input = registers[String(tokens[0])] ?? 0
    let flag = registers[String(tokens[4])] ?? 0
    var act = false
    switch tokens[5]{
    case "==":
        act = flag == Int(tokens[6])!
    case "!=":
        act = flag != Int(tokens[6])!
    case "<":
        act = flag < Int(tokens[6])!
    case ">":
        act = flag > Int(tokens[6])!
    case "<=":
        act = flag <= Int(tokens[6])!
    case ">=":
        act = flag >= Int(tokens[6])!
    default:
        print(line)
        assert(false)
    }
    if act {
        if tokens[1] == "inc" {
            registers[String(tokens[0])] = input + Int(tokens[2])!
        } else {
            registers[String(tokens[0])] = input - Int(tokens[2])!
        }
        if registers[String(tokens[0])]! > max {
            max = registers[String(tokens[0])]!
            out = String(tokens[0])
        }
    }
}

print(out, max)

print("\n\n\n-----\tPart 1\t-----\n\n\n")


max = -99999999
out = ""
for k in registers.keys{
    if registers[k]!>max {
        max = registers[k]!
        out = k
    }
}

print(out, max)

