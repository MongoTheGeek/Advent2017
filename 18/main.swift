//
//  main.swift
//  18
//
//  Created by Mark Lively on 12/18/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

var registers = Dictionary<String,Int>()

func registerOrInt(_ input:String) ->Int{
    return Int(input) ?? registers[input] ?? 0
}

func parse(_ text:String)->Int{
    let lines = text.split(separator: "\n")
    var pos = 0
    var sound = 0
    while true{
        let l = lines[pos]
        let t = l.split(separator: " ")
        //    let command = String(describing: [t[0]])
        let register = String(t[1])
        switch t[0]{
        case "set":
            registers[register] = registerOrInt(String(t[2]))
        case "mul":
            registers[register] = (registers[register] ?? 0) * registerOrInt(String(t[2]))
        case "jgz":
            if registerOrInt(String(t[1])) > 0 {
                pos +=  registerOrInt(String(t[2])) - 1
            }
        case "mod":
            registers[register] = (registers[register] ?? 0) % registerOrInt(String(t[2]))
        case "add":
            registers[register] = (registers[register] ?? 0) + registerOrInt(String(t[2]))
        case "snd":
            sound = registerOrInt(String(t[1]))
        case "rcv":
            if registerOrInt(String(t[1])) > 0 {
                return sound
            }
        default:
            assert(false)
        }
        pos += 1
    }
}

var test = """
set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2
"""


print(parse(test))

print(parse(input))

print("\n\n\n-----\tPart 2\t-----\n\n\n")

func registerOrInt(_ registers:Dictionary<String, Int>,_ input:String) ->Int{
    return Int(input) ?? registers[input] ?? 0
}


func countSend(_ text:String, _ inRegisters:Dictionary<String, Int>, _  messages:Array<Int>, _ position:Int)->(Dictionary<String,Int>,Array<Int>,Int){
    let lines = text.split(separator: "\n")
    var registers = inRegisters
    var pos = position
    var recieved = 0
    var sound = Array<Int>()
    while true{
        let l = lines[pos]
        let t = l.split(separator: " ")
        //    let command = String(describing: [t[0]])
        let register = String(t[1])
        switch t[0]{
        case "set":
            registers[register] = registerOrInt(registers, String(t[2]))
        case "mul":
            registers[register] = (registers[register] ?? 0) * registerOrInt(registers, String(t[2]))
        case "jgz":
            if registerOrInt(registers, String(t[1])) > 0 {
                pos +=  registerOrInt(registers, String(t[2])) - 1
            }
        case "mod":
            registers[register] = (registers[register] ?? 0) % registerOrInt(registers, String(t[2]))
        case "add":
            registers[register] = (registers[register] ?? 0) + registerOrInt(registers, String(t[2]))
        case "snd":
            sound.append(registerOrInt(registers, String(t[1])))
        case "rcv":
            if recieved == messages.count {
                return (registers,sound,pos)
            } else {
                registers[register] = messages[recieved]
                recieved += 1
            }
        default:
            assert(false)
        }
        pos += 1
    }
}

let test2 = """
snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d
"""

var r0 = ["p":0]
var r1 = ["p":1]
var p0 = 0
var p1 = 0
var s0 = 0
var s1 = 0
var sound = Array<Int>()
repeat {
    (r0,sound,p0) = countSend(input, r0, sound, p0)
    s0 += sound.count
    (r1,sound,p1) = countSend(input, r1, sound, p1)
    s1 += sound.count
} while sound.count > 0

print(s0, s1)
