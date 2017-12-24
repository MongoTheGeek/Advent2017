//
//  main.swift
//  23
//
//  Created by Mark Lively on 12/23/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation


var registers = Dictionary<String,Int>()
var mulCount = 0

func registerOrInt(_ input:String) ->Int{
    return Int(input) ?? registers[input] ?? 0
}

func parse(_ text:String)->Int{
    let lines = text.split(separator: "\n")
    var pos = 0
    var sound = 0
    while true{
        if pos >= lines.count {return 0}
        let l = lines[pos]
        if pos == 23 {print(l, registers)}
        let t = l.split(separator: " ")
        //    let command = String(describing: [t[0]])
        let register = String(t[1])
        switch t[0]{
        case "set":
            registers[register] = registerOrInt(String(t[2]))
        case "mul":
            registers[register] = (registers[register] ?? 0) * registerOrInt(String(t[2]))
            mulCount += 1
        case "jgz":
            if registerOrInt(String(t[1])) > 0 {
                pos +=  registerOrInt(String(t[2])) - 1
            }
        case "jnz":
            if registerOrInt(String(t[1])) != 0 {
                pos +=  registerOrInt(String(t[2])) - 1
            }
        case "mod":
            registers[register] = (registers[register] ?? 0) % registerOrInt(String(t[2]))
        case "add":
            registers[register] = (registers[register] ?? 0) + registerOrInt(String(t[2]))
        case "sub":
            registers[register] = (registers[register] ?? 0) - registerOrInt(String(t[2]))
        case "snd":
            sound = registerOrInt(String(t[1]))
        case "rcv":
            if registerOrInt(String(t[1])) > 0 {
                return sound
            }
        default:
            print(l)
            assert(false)
        }
        pos += 1
    }
}

print(parse(input))
print(mulCount)
print(registers)

print("\n\n\n-----\tPart 2\t-----\n\n\n")
//
//
//registers=["a":1]
//parse(input)
//print(registers)

let b = 105700
let c = 122700
var count = 0
for i in 0...((c-b)/17)+1{
    let t = b + i * 17
    var j = 1
    while j < Int(sqrt(Double(b))){
        j+=1
        if t % j == 0 {
            print(t)
            count += 1
            break
        }
    }
}
print(count)
