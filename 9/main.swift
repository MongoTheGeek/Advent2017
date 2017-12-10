//
//  main.swift
//  9
//
//  Created by Mark Lively on 12/8/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

func parse(_ data:String) -> (Int, Int) {
    var cleaned = 0
    var output = 0
    var garbage = false
    var level = 0
    var not = false
    for char in data{
        switch char {
        case "<":
            if garbage && !not {cleaned += 1}
            if !garbage {garbage = true}
            not = false
        case "!":
            if !not {not = true} else {not = false}
        case "{":
            if !garbage {
                level += 1
            }
            if garbage && !not {cleaned += 1}
            not = false
        case "}":
            if !garbage {
                output += level
                level -= 1
            }
            if garbage && !not {cleaned += 1}
            not = false
        case ">":
            if !not {garbage = false}
            not = false
        default:
            if garbage && !not {cleaned += 1}
            not = false
        }
    }
    return (output, cleaned)
}


let test1 = "{}" // score of 1.
let test2 = "{{{}}}" // score of 1 + 2 + 3 = 6.
let test3 = "{{},{}}" // score of 1 + 2 + 2 = 5.
let test4 = "{{{},{},{{}}}}" // score of 1 + 2 + 3 + 3 + 3 + 4 = 16.
let test5 = "{<a>,<a>,<a>,<a>}" // score of 1.
let test6 = "{{<ab>},{<ab>},{<ab>},{<ab>}}" // score of 1 + 2 + 2 + 2 + 2 = 9.
let test7 = "{{<!!>},{<!!>},{<!!>},{<!!>}}" // score of 1 + 2 + 2 + 2 + 2 = 9.
let test8 = "{{<a!>},{<a!>},{<a!>},{<ab>}}" // score of 1 + 2 = 3.

print(parse(test1))
print(parse(test2))
print(parse(test3))
print(parse(test4))
print(parse(test5))
print(parse(test6))
print(parse(test7))
print(parse(test8))

print(parse(input))


print("\n\n\n-----\tPart 2\t-----\n\n\n")

let test11 = "<>"//, 0 characters.
let test12 = "<random characters>"//, 17 characters.
let test13 = "<<<<>"//, 3 characters.
let test14 = "<{!>}>"//, 2 characters.
let test15 = "<!!>"//, 0 characters.
let test16 = "<!!!>>"//, 0 characters.
let test17 = "<{o\"i!a,<{i<a>"//, 10 characters.

print(parse(test11))
print(parse(test12))
print(parse(test13))
print(parse(test14))
print(parse(test15))
print(parse(test16))
print(parse(test17))
print(parse(input))
